//
// Created by Joshua Sullivan on 2/26/15.
// Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

@import Foundation;
@import CoreGraphics;
#import "JTSAnimatorTypes.h"

@class JTSTweener;

/**
* The JTSTweenProgressBlock is triggered every tick that the value changes.
* NOTE: It will also trigger at 0% and 100% unless suppressed in the options.
*
* @param tween The JTSTweener that is firing the progress block.
* @param value The current value of the tween.
* @param elapsedTime The time elapsed thus far on the tween (will fall in the range 0 - duration, inclusive).
*/
typedef void (^JTSTweenProgressBlock)(JTSTweener *tween, CGFloat value, NSTimeInterval elapsedTime);

/**
* Triggered after the 100% progress block invocation.
*
* @param tween The JTSTweener that is firing the progress block.
* @param completedSuccessfully Returns YES if the tweener reached 100% prior to completing.
*/
typedef void (^JTSTweenCompletionBlock)(JTSTweener *tween, BOOL completedSuccessfully);

@interface JTSTweener : NSObject

+ (JTSTweener *)tweenerWithDuration:(NSTimeInterval)duration
                      startingValue:(CGFloat)startingValue
                        endingValue:(CGFloat)endingValue
                        easingCurve:(EasingCurve)easingCurve
                            options:(NSDictionary *)optionsOrNil
                      progressBlock:(JTSTweenProgressBlock)progressBlock
                    completionBlock:(JTSTweenCompletionBlock)completionBlock;

@property (assign) CGFloat startingValue;
@property (assign) CGFloat endingValue;
@property (assign) EasingCurve easingCurve;
@property (readonly) NSDictionary *options;

@end