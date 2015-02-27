//
//  JTSEaseCubic.h
//  JTSAnimator
//
//  Created by Joshua Sullivan on 2/26/15.
//  Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

@import Foundation;
#import "JTSAnimatorTypes.h"

@interface JTSEaseCubic : NSObject

+ (RatioTransformer)easeIn;
+ (RatioTransformer)easeOut;
+ (RatioTransformer)easeInOut;

@end
