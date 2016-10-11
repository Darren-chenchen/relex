//
//  UIView+CL.m
//  Relax
//
//  Created by Darren on 16/6/6.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "UIView+CL.h"

@implementation UIView (CL)
- (void)setCl_x:(CGFloat)Cl_x
{
    CGRect frame = self.frame;
    frame.origin.x = Cl_x;
    self.frame = frame;
}
- (CGFloat)cl_x
{
    return self.frame.origin.x;
}

- (void)setCl_y:(CGFloat)Cl_y
{
    CGRect frame = self.frame;
    frame.origin.y = Cl_y;
    self.frame = frame;
}

- (CGFloat)cl_y
{
    return self.frame.origin.y;
}

- (void)setCl_w:(CGFloat)Cl_w
{
    CGRect frame = self.frame;
    frame.size.width = Cl_w;
    self.frame = frame;
}

- (CGFloat)cl_w
{
    return self.frame.size.width;
}

- (void)setCl_h:(CGFloat)Cl_h
{
    CGRect frame = self.frame;
    frame.size.height = Cl_h;
    self.frame = frame;
}

- (CGFloat)cl_h
{
    return self.frame.size.height;
}

- (void)setCl_size:(CGSize)Cl_size
{
    CGRect frame = self.frame;
    frame.size = Cl_size;
    self.frame = frame;
}

- (CGSize)cl_size
{
    return self.frame.size;
}

- (void)setCl_origin:(CGPoint)Cl_origin
{
    CGRect frame = self.frame;
    frame.origin = Cl_origin;
    self.frame = frame;
}

- (CGPoint)cl_origin
{
    return self.frame.origin;
}

- (void)setCl_centerX:(CGFloat)cl_centerX
{
    CGPoint center = self.center;
    center.x = cl_centerX;
    self.center = center;
}
- (CGFloat)cl_centerX
{
    return self.center.x;
}

- (void)setCl_centerY:(CGFloat)cl_centerY
{
    CGPoint center = self.center;
    center.y = cl_centerY;
    self.center = center;
}
- (CGFloat)cl_centerY
{
    return self.center.y;
}

@end
