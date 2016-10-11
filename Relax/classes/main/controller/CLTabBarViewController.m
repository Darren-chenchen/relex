//
//  CLTabBarViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLTabBarViewController.h"
#import "CLTabBarVIew.h"
#import "CLFunViewController.h"
#import "CLNewMainViewController.h"
#import "CLGameBaseViewController.h"
#import "MeViewController.h"
#import "UIImageView+WebCache.h"
#import "CLMyCenterViewController.h"
#import "CLFunMainViewController.h"
@interface CLTabBarViewController ()<CLTabBarVIewDelegate>

@property (nonatomic,weak) CLTabBarVIew *CLTabBar;

/**标记是否是第一次启动*/
@property (nonatomic,assign) NSInteger index;
/**启动也*/
@property (nonatomic,weak) UIView *launchView;
/**跳过*/
@property (nonatomic,weak) UIButton *jumpBtn;
@end

@implementation CLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
    // 好笑
    CLFunMainViewController *headPage = [[CLFunMainViewController alloc] init];
    [self addChildViewController:headPage andTitle:@"开心一刻" andImage:@"funSelected" andSelectedImage:@"fun"];
    UINavigationController *navHead = [[UINavigationController alloc] initWithRootViewController:headPage];
    [self addChildViewController:navHead];
    
    // 新闻
    CLNewMainViewController *categoryController = [[CLNewMainViewController alloc] init];
    [self addChildViewController:categoryController andTitle:@"新闻汇总" andImage:@"newsSelected" andSelectedImage:@"news"];
    UINavigationController *navcategory = [[UINavigationController alloc] initWithRootViewController:categoryController];
    [self addChildViewController:navcategory];
    
    // 游戏
    CLGameBaseViewController *lightning = [[CLGameBaseViewController alloc] init];
    [self addChildViewController:lightning andTitle:@"游戏" andImage:@"gameSelected" andSelectedImage:@"game"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lightning];
    [self addChildViewController:nav];
    
    //我
    CLMyCenterViewController *me = [[CLMyCenterViewController alloc] init];
    [self addChildViewController:me andTitle:@"我" andImage:@"me" andSelectedImage:@"meselected"];
    [self addChildViewController:me];
}

// 移除系统自带的tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.index == 0) {
        UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Launch Screen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
        UIView *launchView = viewController.view;
        self.launchView = launchView;
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        launchView.frame = CGRectMake(0, 0, CLScreenW, CLScreenH);
        [mainWindow addSubview:launchView];
        
        UIImageView *Img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,  CLScreenH-115, CLScreenW, 115)];
        Img2.image = [UIImage imageNamed:@"first-2"];
        [launchView addSubview:Img2];
        
        for (int i = 0; i < 4; i++) {
            CGFloat imgW = 50;
            CGFloat imgH = imgW;
            CGFloat imgX = 50+(imgW+20)*i;
            CGFloat imgY = -imgW;
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
            img.layer.cornerRadius = imgW*0.5;
            img.layer.masksToBounds = YES;
            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"f%d",i+1]];
            [launchView addSubview:img];
            
            [UIView animateWithDuration:0.5 delay:i*0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                img.mj_y = 200;
            } completion:^(BOOL finished) {
                
                if (i == 3) {
                    for (int i = 0; i < 3; i++) {
                        CGFloat imgW = 50;
                        CGFloat imgH = imgW;
                        CGFloat imgX = (CLScreenW-190)*0.5+(imgW+20)*i;
                        CGFloat imgY = CLScreenH;
                        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
                        img.layer.cornerRadius = imgW*0.5;
                        img.layer.masksToBounds = YES;
                        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"f%d",i+5]];
                        [launchView addSubview:img];
                        
                        [UIView animateWithDuration:0.5 delay:i*0.05 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            img.mj_y = 300;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }

                }
                
            }];
        }
        
        // 跳过
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CLScreenW-70, 20, 50, 30)];
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.8]];
        [btn addTarget:self action:@selector(clickJump) forControlEvents:UIControlEventTouchUpInside];
        [mainWindow addSubview:btn];
        self.jumpBtn = btn;
        
        [UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            launchView.mj_y = CLScreenH;
            [self.jumpBtn removeFromSuperview];
            self.jumpBtn = nil;
        } completion:^(BOOL finished) {
            [launchView removeFromSuperview];
        }];
    }
    self.index ++;
}
- (void)clickJump
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.launchView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.launchView removeFromSuperview];
    }];
    [self.jumpBtn removeFromSuperview];
    self.jumpBtn = nil;
}
// 自定义tabbar覆盖系统的tabbar
- (void)setupTabBar
{
    CLTabBarVIew *CLTabBar = [[CLTabBarVIew alloc] initWithFrame:self.tabBar.bounds];
    [self.tabBar addSubview:CLTabBar];
    self.CLTabBar = CLTabBar;
    self.CLTabBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    CLTabBar.delegate = self;
}

// 初始化子控制器
- (void)addChildViewController:(UIViewController *)child andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    child.tabBarItem.title = title;
    child.tabBarItem.image = [UIImage imageNamed:image];
    child.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    [self.CLTabBar addCustomButtonWithitem:child.tabBarItem];
}

#pragma mark - 代理方法
- (void)tabbar:(CLTabBarVIew *)tabbar DidSeletedFrom:(NSInteger)from To:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
