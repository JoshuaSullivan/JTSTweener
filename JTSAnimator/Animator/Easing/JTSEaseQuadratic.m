//
//  JTSEaseQuadratic.m
//  JTSAnimator
//
//  Created by Joshua Sullivan on 2/26/15.
//  Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "JTSEaseQuadratic.h"

@implementation JTSEaseQuadratic

+ (RatioTransformer)easeIn
{
    static RatioTransformer _easeIn;
    if (!_easeIn) {
        _easeIn = ^CGFloat(CGFloat ratio) {
            return ratio * ratio;
        };
    }
    return _easeIn;
}

+ (RatioTransformer)easeOut
{
    static RatioTransformer _easeOut;
    if (!_easeOut) {
        _easeOut = ^CGFloat(CGFloat ratio) {
            return -(ratio * (ratio - 2));
        };
    }
    return _easeOut;
}

+ (RatioTransformer)easeInOut
{
    static RatioTransformer _easeInOut;
    if (!_easeInOut) {
        _easeInOut = ^CGFloat(CGFloat ratio) {
            if (ratio < 0.5) {
                return 2 * ratio * ratio;
            }
            else {
                return (-2 * ratio * ratio) + (4 * ratio) - 1;
            }
        };
    }
    return _easeInOut;
}


@end
