//
//  UIView+CL.h
//  Relax
//
//  Created by Darren on 16/6/6.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CL)
@property (assign, nonatomic) CGFloat cl_x;
@property (assign, nonatomic) CGFloat cl_y;
@property (assign, nonatomic) CGFloat cl_w;
@property (assign, nonatomic) CGFloat cl_h;
@property (assign, nonatomic) CGSize cl_size;
@property (assign, nonatomic) CGPoint cl_origin;

@property (assign, nonatomic) CGFloat cl_centerX;
@property (assign, nonatomic) CGFloat cl_centerY;

@end
