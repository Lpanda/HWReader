//
//  AnimationKit.m
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#import "AnimationKit.h"

#define COMPLETIOAN_DELAY   0.2f

@implementation AnimationKit

+(void)showTransitionByType:(NSString *)transitionType
                      subType:(NSString *)subType
                     duration:(NSTimeInterval)duration
               timingFunction:(UIViewAnimationCurve)timingFunction
                      atLayer:(CALayer *)atLayer
                   animations:(void (^)())animations
{
    [self showTransitionByType:transitionType
                       subType:subType
                      duration:duration
                timingFunction:timingFunction
                       atLayer:atLayer
                    animations:animations
                  completion:nil];
}

+(void)showTransitionByType:(NSString *)transitionType
                    subType:(NSString *)subType
                   duration:(NSTimeInterval)duration
             timingFunction:(UIViewAnimationCurve)timingFunction
                    atLayer:(CALayer *)atLayer
                 animations:(void (^)())animations
               completion:(void (^)())completion
{
    CATransition *transition = [CATransition animation];
    transition.type = transitionType;
    transition.subtype = subType;
    transition.duration = duration;
    transition.timingFunction = (CAMediaTimingFunction *)timingFunction;
    
    if (animations) {
        animations();
    }
    
    [atLayer addAnimation:transition forKey:nil];
    
    if (completion) {
        double delayInSeconds = duration + COMPLETIOAN_DELAY;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            completion();
        });
    }
}

@end
