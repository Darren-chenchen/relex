//
//  CLFunMainViewController.m
//  Relax
//
//  Created by Darren on 16/6/6.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLFunMainViewController.h"
#import "CLFunViewController.h"
#import "CLFavoriteViewController.h"
#import "AppDelegate.h"
#import "UserCommantViewController.h"

@interface CLFunMainViewController()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@property (nonatomic,weak) UIButton *favoriteBtn;

@property (nonatomic,weak) UIView *coverView;

@property (nonatomic,assign) BOOL isUserCommantController; // 判断是否是让用户判断的控制器

@end

@implementation CLFunMainViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"开心一刻";
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
    
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"countRecord.data"]];
    if (array.count >= 20) {
        
//        // 添加一个阴影
//        UIView *views = [[UIView alloc] initWithFrame:self.view.frame];
//        views.backgroundColor = [UIColor blackColor];
//        views.alpha = 0.5;
//        [self.view addSubview:views];
//        [self.navigationController.view addSubview:views];
//        self.coverView = views;
//        
//        // 弹框，让用户选择是否去评论
//        [self letUsersToCommant];
//        // 清零
//        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"countRecord.data"];
//        NSFileManager* fileManager=[NSFileManager defaultManager];
//        [fileManager removeItemAtPath:path error:nil];
    }
    
    // 去评论控制器显示后移除阴影
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCover) name:@"removeCover" object:nil];
}
- (void)removeCover
{
    [self.coverView removeFromSuperview];
    self.coverView = nil;
}
- (void)letUsersToCommant
{
    //出现警告 Presenting view controllers on detached view controllers is discouraged
    //viewController被提前入栈了，要拿到当前的viewController
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *w = delegate.window;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    CLFunViewController *fun = [[CLFunViewController alloc] init];
    fun.title = @"糗事汇总";
    fun.type = 1;
    [self addChildViewController:fun];
    
    CLFunViewController *all = [[CLFunViewController alloc] init];
    all.title = @"经典笑话";
    all.type = 2;
    [self addChildViewController:all];
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = ALPHACOLOR;
    titlesView.mj_w = CLScreenW;
    titlesView.mj_h = 30;
    titlesView.mj_y =64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.mj_h = 2;
    indicatorView.tag = -1;
    indicatorView.mj_y = titlesView.mj_h - indicatorView.mj_h;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.mj_w*0.5;
    CGFloat height = titlesView.mj_h;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.mj_h = height;
        button.mj_w = width;
        button.mj_x = i * width;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:ALPHACOLOR];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.mj_w = button.titleLabel.mj_w;
            self.indicatorView.cl_centerX = button.cl_centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.mj_w = button.titleLabel.mj_w;
        self.indicatorView.cl_centerX = button.cl_centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.cl_w;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.cl_w * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 * 设置导航栏
 */
- (void)setupNav
{
    self.navigationController.navigationBar.barTintColor = ALPHACOLOR;
    self.navigationController.navigationBar.tintColor = ALPHACOLOR;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"funSelected"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor colorWithRed:200/255. green:150/255. blue:80/255. alpha:1] forState:UIControlStateNormal];
    self.favoriteBtn = btn;
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -18.0;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
}
/**点击我的收藏*/
- (void)clickBtn
{
    CLFavoriteViewController *favorite = [[CLFavoriteViewController alloc] init];
    favorite.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:favorite animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.cl_w;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.cl_x = scrollView.contentOffset.x;
    vc.view.cl_y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.cl_h = scrollView.cl_h; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.cl_w;
    [self titleClick:self.titlesView.subviews[index]];
}
@end
