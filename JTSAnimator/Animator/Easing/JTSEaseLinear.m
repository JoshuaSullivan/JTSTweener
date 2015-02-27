//
//  JTSEaseLinear.m
//  JTSAnimator
//
//  Created by Joshua Sullivan on 2/26/15.
//  Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "JTSEaseLinear.h"

@implementation JTSEaseLinear

+ (RatioTransformer)easeNone
{
    static RatioTransformer _easer;
    if (!_easer) {
        _easer = ^CGFloat(CGFloat ratio) {
            return ratio;
        };
    }
    return _easer;
}


@end
