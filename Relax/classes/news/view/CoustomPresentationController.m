//
//  CoustomPresentationController.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CoustomPresentationController.h"

@implementation CoustomPresentationController

- (void)presentationTransitionWillBegin
{
    self.presentedView.frame = self.containerView.bounds;
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
