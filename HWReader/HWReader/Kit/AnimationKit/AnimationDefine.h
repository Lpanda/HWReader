//
//  AnimationDefine.h
//  HWReader
//
//  Created by LPanda on 14-8-11.
//  Copyright (c) 2014年 huawei. All rights reserved.
//

#ifndef HWReader_AnimationDefine_h
#define HWReader_AnimationDefine_h

#pragma mark - Radians & Degrees  角度弧度换算

#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f)
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f)

#define ROTATE_PERTIME       0.0166666667

typedef enum
{
    RotateAxis_X = 1,
    RotateAxis_Y = 2,
    RotateAxis_Z = 4,
}RotateAxis;

#pragma mark - Transition timingFunction    过渡时间效果类型

//  四种不同的获取过渡时间的宏定义，区别在于该段时间内，坐标的变化量不同

#define BASEANIMATION_DURATION   0.4f


#define TRANSITION_TIMING_DEFAULT   ((UIViewAnimationCurve)[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault])
#define TRANSITION_TIMING_EASEINEASEOUT   ((UIViewAnimationCurve)[CAMediaTimingFunction \
                                                                            functionWithName:kCAMediaTimingFunctionEaseInEaseOut])
#define TRANSITION_TIMING_EASEOUT   ((UIViewAnimationCurve)[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut])
#define TRANSITION_TIMING_EASEIN     ((UIViewAnimationCurve)[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn])
#define TRANSITION_TIMING_LINEAR    ((UIViewAnimationCurve)[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear])

#pragma mark - Transition Type  过渡效果类型

#define     TRANSITION_TYPE_FADE         kCATransitionFade       //  渐隐渐现效果
#define     TRANSITION_TYPE_MOVEIN       kCATransitionMoveIn     //  覆盖原图效果
#define     TRANSITION_TYPE_PUSH         kCATransitionPush       //  推出效果
#define     TRANSITION_TYPE_REVEAL       kCATransitionReveal     //  底部出现效果

#define     TRANSITION_TYPE_CUBE         @"cube"     //  立方体旋转效果
#define     TRANSITION_TYPE_ALIGNEDCUBE  @"alignedCube"      //  均衡立方体旋转效果

#define     TRANSITION_TYPE_FLIP         @"flip"     //  翻转效果
#define     TRANSITION_TYPE_ALIGNEDFLIP  @"alignedFlip"      //  均衡翻转效果
#define     TRANSITION_TYPE_OGLFLIP      @"oglFlip"      //上下反转效果

#define     TRANSITION_TYPE_PAGECURL     @"pageCurl"     // 上一页翻页效果
#define     TRANSITION_TYPE_PAGEUNCURL   @"pageUnCurl"       //  下一页翻页效果

#define     TRANSITION_TYPE_CAMERAIRIS   @"cameraIris"   //  照相机效果
#define     TRANSITION_TYPE_CAMERAIRIS_HOLLOWOPEN  @"cameraIrisHollowOpen"        //  照相机打开效果
#define     TRANSITION_TYPE_CAMERAIRIS_HOLLOWCLOSE @"cameraIrisHollowClose"       //  照相机关闭效果

#define     TRANSITION_TYPE_ROTATE       @"rotate"       //  旋转效果

#define     TRANSITION_TYPE_RIPPLE_EFFECT @"rippleEffect" //      波纹效果，但是必须传入图片
#define     TRANSITION_TYPE_SUCK_EFFECT   @"suckEffect"   //      吸收效果

# pragma mark Transition SubType

#define TRANSITION_FROM_RIGHT kCATransitionFromRight

#define TRANSITION_FROM_LEFT  kCATransitionFromLeft

#define TRANSITION_FROM_TOP   kCATransitionFromTop

#define TRANSITION_FROM_BOTTOM    kCATransitionFromBottom

#endif
