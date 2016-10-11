//
//  CommantPresentationController.m
//  Relax
//
//  Created by Darren on 16/1/26.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CommantPresentationController.h"

@implementation CommantPresentationController
- (void)presentationTransitionWillBegin
{
    self.presentedView.frame = CGRectMake(0, 0, 200, 200);
    self.presentedView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5,[UIScreen mainScreen].bounds.size.height*0.5);
    [self.containerView addSubview:self.presentedView];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    
}

- (void)dismissalTransitionWillBegin
{
    
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    [self.presentedView removeFromSuperview];
}

@end
