//
//  AnimationKit.h
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationDefine.h"

@interface AnimationKit : NSObject

+(void) showTransitionByType:(NSString*)transitionType
                       subType:(NSString*)subType
                      duration:(NSTimeInterval)duration
                timingFunction:(UIViewAnimationCurve)timingFunction
                       atLayer:(CALayer*)atLayer
                    animations:(void(^)())animations;

+(void) showTransitionByType:(NSString*)transitionType
                     subType:(NSString*)subType
                    duration:(NSTimeInterval)duration
              timingFunction:(UIViewAnimationCurve)timingFunction
                     atLayer:(CALayer*)atLayer
                  animations:(void(^)())animations
                completion:(void(^)())finish;

@end
