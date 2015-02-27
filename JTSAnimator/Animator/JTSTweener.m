//
// Created by Joshua Sullivan on 2/26/15.
// Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "JTSTweener.h"


@interface JTSTweener ()

@end


@implementation JTSTweener

+ (JTSTweener *)tweenerWithDuration:(NSTimeInterval)duration startingValue:(CGFloat)startingValue endingValue:(CGFloat)endingValue easingCurve:(EasingCurve)easingCurve options:(NSDictionary *)optionsOrNil progressBlock:(JTSTweenProgressBlock)progressBlock completionBlock:(JTSTweenCompletionBlock)completionBlock
{
    return [[JTSTweener alloc] init];
}


@end
