//
//  CLNBAAnimatedTransitioning.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLNBAAnimatedTransitioning.h"
#import "UIView+MJExtension.h"

@implementation CLNBAAnimatedTransitioning
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

// 在这个方法中实现转场动画 ：modal和dismis都调用这个方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0) ;
        [UIView animateWithDuration:1 animations:^{
            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:1 animations:^{
            fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0) ;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    }
}

@end
