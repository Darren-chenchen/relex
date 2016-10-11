//
//  CLMyCenterViewController.m
//  Relax
//
//  Created by Darren on 16/6/4.
//  Copyright © 2016年 darren. All rights reserved.
//


#import "CLMyCenterViewController.h"
#import "LoginViewController.h"
#import "CLFavoriteViewController.h"
#import "CLFavoriteAnimatedTransitioning.h"
#import "CoustomPresentationController.h"
#import "NewsFavViewController.h"
#import "GameFavViewController.h"
#import "UIImage+MJ.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDK/ShareSDK.h>

@interface CLMyCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak) UIImageView *imageView;  // tableview头部空间
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,weak) UILabel *userLable;  // 显示账号的lable
@property (nonatomic,weak) UIImageView *loginView;// 圆形的头像
@property (nonatomic,weak) UIButton *btn;//显示“登录”的 btn
@property (nonatomic,weak) UIButton *btnExit;// 退出按钮
@property (nonatomic,weak) UIButton *cameraBtn;
@end

@implementation CLMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
}
- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"笑话收藏",@"新闻收藏",@"游戏收藏"];
    }
    return _array;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new]; // 去掉多余的横线
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 200)];
    imageView.image = [UIImage imageNamed:@"1"];
    imageView.userInteractionEnabled= YES;
    self.imageView = imageView;
    [tableView addSubview:imageView];
}

- (void)clickShareBtn
{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"512.png"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"这个应用还不错，快来看看吧......"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1070843107"]
                                          title:@"累了吗"
                                           type:SSDKContentTypeAuto];
        
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MeID = @"meCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + 200)/2;
    
    if (yOffset < -200) {
        
        CGRect rect = self.imageView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = self.view.frame.size.width + fabs(xOffset)*2;
        
        self.imageView.frame = rect;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
            CLFavoriteViewController *favorite = [[CLFavoriteViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 1){
            NewsFavViewController *favorite = [[NewsFavViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
    } else if (indexPath.row == 2){
            GameFavViewController *favorite = [[GameFavViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
    }
}
#pragma mark - UIViewControllerTransitioningDelegate
//这个方法是说明哪个控制器控制presentatingController、presentatedController
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CoustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

// 自定义PresentedController的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{   CLFavoriteAnimatedTransitioning *anim = [[CLFavoriteAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLFavoriteAnimatedTransitioning *anim = [[CLFavoriteAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}
@end
