//
//  JTSEaseCubic.m
//  JTSAnimator
//
//  Created by Joshua Sullivan on 2/26/15.
//  Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "JTSEaseCubic.h"

@implementation JTSEaseCubic

+ (RatioTransformer)easeIn
{
    static RatioTransformer _easeIn;
    if (!_easeIn) {
        _easeIn = ^CGFloat(CGFloat ratio) {
            return ratio * ratio * ratio;
        };
    }
    return _easeIn;
}

+ (RatioTransformer)easeOut
{
    static RatioTransformer _easeOut;
    if (!_easeOut) {
        _easeOut = ^CGFloat(CGFloat ratio) {
            CGFloat r = 1.0f - ratio;
            return r * r * r + 1;
        };
    }
    return _easeOut;
}

+ (RatioTransformer)easeInOut
{
    static RatioTransformer _easeInOut;
    if (!_easeInOut) {
        _easeInOut = ^CGFloat(CGFloat ratio) {
            if (ratio < 0.5f) {
                return 4.0f * ratio * ratio * ratio;
            }
            else {
                CGFloat r = ((2.0f * ratio) - 2.0f);
                return 0.5f * r * r * r + 1;
            }
        };
    }
    return _easeInOut;
}


@end
