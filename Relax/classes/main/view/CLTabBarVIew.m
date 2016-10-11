//
//  CLTabBarVIew.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLTabBarVIew.h"
#import "CLCustomButton.h"

@interface CLTabBarVIew()

@property(nonatomic,strong)NSMutableArray *customBtns;
@property(nonatomic,weak)CLCustomButton *selectedBtn;

@end

@implementation CLTabBarVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*懒加载*/
- (NSMutableArray *)customBtns
{
    if (_customBtns == nil) {
        _customBtns = [NSMutableArray array];
    }
    return _customBtns;
}

// 一次添加3个button,在每创建一个控制器是就会调用一次这个方法
- (void)addCustomButtonWithitem:(UITabBarItem *)item
{
    CLCustomButton *customBtn = [[CLCustomButton alloc] init];
    customBtn.item = item;
    
    [self addSubview:customBtn];
    [self.customBtns addObject:customBtn];
    
    //监听按钮点击
    [customBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchDown];
}

- (void)clickbtn:(CLCustomButton *)btn;
{
    if ([self.delegate respondsToSelector:@selector(tabbar:DidSeletedFrom:To:)]) {
        [self.delegate tabbar:self DidSeletedFrom:self.selectedBtn.tag To:btn.tag];
    }
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

/*设置按钮的尺寸*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        CGFloat btnX = i * btnW;
        CLCustomButton *btn = self.customBtns[i];
        btn.tag = i;
        if (btn.tag == 0) {
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
@end
