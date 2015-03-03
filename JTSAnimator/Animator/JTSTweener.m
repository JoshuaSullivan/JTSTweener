//
// Created by Joshua Sullivan on 2/26/15.
// Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "JTSTweener.h"


@interface JTSTweener ()

@property (assign, nonatomic) CGFloat valueChange;
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
    return [[JTSTweener alloc] initWithDuration:duration
                                  startingValue:startingValue
                                    endingValue:endingValue
                                    easingCurve:easingCurve
                                        options:optionsOrNil
                                  progressBlock:progressBlock
                                completionBlock:completionBlock];
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
    _valueChange = endingValue - startingValue;
    _easingCurve = [easingCurve copy];
    _options = optionsOrNil;
    self.progressBlock = progressBlock;
    self.completionBlock = completionBlock;
    return self;
}

- (void)setStartingValue:(CGFloat)startingValue
{
    _startingValue = startingValue;
    self.valueChange = self.endingValue - startingValue;
}

- (void)setEndingValue:(CGFloat)endingValue
{
    _endingValue = endingValue;
    self.valueChange = endingValue - self.startingValue;
}

@end
