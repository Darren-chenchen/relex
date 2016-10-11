//
//  CLCarAnimatedTransitioning.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLCarAnimatedTransitioning.h"
#import "UIView+MJExtension.h"

@implementation CLCarAnimatedTransitioning
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
        toView.mj_x = -toView.mj_w;
        [UIView animateWithDuration:1 animations:^{
            toView.mj_x = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        fromView.mj_x = 0;
        [UIView animateWithDuration:1 animations:^{
            fromView.mj_x = -fromView.mj_w;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    }
}

@end
