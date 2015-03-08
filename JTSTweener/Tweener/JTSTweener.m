//
// Created by Joshua Sullivan on 2/26/15.
// Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

@import QuartzCore;
#import "JTSTweener.h"

const CFTimeInterval kDroppedFrameThreshold = 0.5;

static NSMutableArray *_tweeners;
static CADisplayLink *_displayLink;
static CFTimeInterval _prevTimestamp = -1.0;

@interface JTSTweener ()

@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) BOOL isComplete;
@property (assign, nonatomic) CGFloat valueDifference;
@property (assign, nonatomic) CFTimeInterval elapsedTime;
@property (copy, nonatomic) JTSTweenProgressBlock progressBlock;
@property (copy, nonatomic) JTSTweenCompletionBlock  completionBlock;

@end

@implementation JTSTweener

+ (JTSTweener *)tweenerWithDuration:(NSTimeInterval)duration
                      startingValue:(CGFloat)startingValue
                        endingValue:(CGFloat)endingValue
                        easingCurve:(EasingCurve)easingCurve
                            options:(NSDictionary *)optionsOrNil
                      progressBlock:(JTSTweenProgressBlock)progressBlock
                    completionBlock:(JTSTweenCompletionBlock)completionBlock
{
    JTSTweener *tweener = [[JTSTweener alloc] initWithDuration:duration
                                  startingValue:startingValue
                                    endingValue:endingValue
                                    easingCurve:easingCurve
                                        options:optionsOrNil
                                  progressBlock:progressBlock
                                completionBlock:completionBlock];
    [self registerTweener:tweener];
    return tweener;
}
/**
* This is the designated initializer for the class.
*/
- (instancetype)initWithDuration:(NSTimeInterval)duration
                   startingValue:(CGFloat)startingValue
                     endingValue:(CGFloat)endingValue
                     easingCurve:(EasingCurve)easingCurve
                         options:(NSDictionary *)optionsOrNil
                   progressBlock:(JTSTweenProgressBlock)progressBlock
                 completionBlock:(JTSTweenCompletionBlock)completionBlock
{
    self = [super init];
    if (!self) {
        NSLog(@"%@ failed to init.", NSStringFromClass([self class]));
        return nil;
    }
    _duration = duration;
    _startingValue = startingValue;
    _endingValue = endingValue;
    _valueDifference = endingValue - startingValue;
    _easingCurve = [easingCurve copy];
    _options = optionsOrNil;
    self.progressBlock = progressBlock;
    self.completionBlock = completionBlock;
    _elapsedTime = 0.0;
    [self update:0.0];
    return self;
}

- (void)setStartingValue:(CGFloat)startingValue
{
    _startingValue = startingValue;
    self.valueDifference = self.endingValue - startingValue;
}

- (void)setEndingValue:(CGFloat)endingValue
{
    _endingValue = endingValue;
    self.valueDifference = endingValue - self.startingValue;
}

- (void)pause
{
    self.isPaused = YES;
}

- (void)resume
{
    self.isPaused = NO;
}

- (void)cancel
{
    self.completionBlock(self, NO);
    [self destroy];
}

- (void)destroy
{
    _easingCurve = NULL;
    _progressBlock = NULL;
    _completionBlock = NULL;
}

- (void)update:(CFTimeInterval)interval
{
    self.elapsedTime += interval;
    if (self.elapsedTime >= self.duration) {
        self.elapsedTime = self.duration;
        self.isComplete = YES;
    }
    CGFloat ratio = (CGFloat)fmin((self.elapsedTime / self.duration), 1.0);
    CGFloat easedRatio = self.easingCurve(ratio);
    CGFloat value = easedRatio * self.valueDifference + self.startingValue;
    if (self.progressBlock) {
        self.progressBlock(self, value, self.elapsedTime);
    }
    if (self.isComplete && self.completionBlock) {
        self.completionBlock(self, YES);
    }
}

+ (void)registerTweener:(JTSTweener *)tweener
{
    if (!_tweeners) {
        _tweeners = [NSMutableArray array];
    }
    [_tweeners addObject:tweener];
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLinkTick:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    _displayLink.paused = NO;
}

+ (void)handleDisplayLinkTick:(CADisplayLink *)displayLink
{
    CFTimeInterval dt = displayLink.timestamp - _prevTimestamp;
    if (_prevTimestamp < 0.0 || dt > kDroppedFrameThreshold) {
        _prevTimestamp = displayLink.timestamp;
        return;
    }
    NSMutableArray *completedTweeners = [NSMutableArray array];
    for (JTSTweener *tweener in _tweeners) {
        if (tweener.isComplete) {
            [completedTweeners addObject:tweener];
            [tweener destroy];
        } else if (!tweener.isPaused) {
            [tweener update:dt];
        }
    }
    if (completedTweeners.count > 0) {
        [_tweeners removeObjectsInArray:completedTweeners];
    }
    _prevTimestamp = displayLink.timestamp;
    if (_tweeners.count == 0) {
        _prevTimestamp = -1.0;
        _displayLink.paused = YES;
    }
}

@end
