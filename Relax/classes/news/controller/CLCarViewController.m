//
//  CLCarViewController.m
//  Relax
//
//  Created by Darren on 16/1/11.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLCarViewController.h"
#import "Request.h"
#import "CLNewsTableViewCell.h"
#import "CLCarModel.h"
#import "CLNewSixTableViewCell.h"
#import "CLCarModel.h"
#import "CLCarWebViewController.h"
#import "CoustomPresentationController.h"
#import "CLCarAnimatedTransitioning.h"
#import <MJRefresh.h>

@interface CLCarViewController ()<UITableViewDataSource,UITableViewDelegate,RequestDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) NSMutableArray *mutArray;
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,assign) BOOL isFootRefresh;
@property (nonatomic,assign) int page;

@end

@implementation CLCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"汽车资讯";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    self.page = 1;
    [self setupTableView];
}
- (NSMutableArray *)mutArray
{
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}

- (void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(foot)];
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(head)];
    [tableview.mj_header beginRefreshing];
}

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)head
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self netRequest];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}
- (void)foot
{
    self.isFootRefresh = YES;
    // 延迟1秒自动停止
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.page ++;
        [self netRequest];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    });
}


- (void)netRequest
{
    Request *request = [[Request alloc] init];
    request.delegate = self;
    request.type = @"application/json";
    NSString *urlStr1 = [NSString stringWithFormat:@"%d",self.page];
    [request  requestDataFromUrlString:[NSString stringWithFormat:@"http://api.ycapp.yiche.com/appnews/toutiaov64/?page=%@&length=20&platform=2&deviceid=82B28D6F12640575BBA8002156C4CAF6",urlStr1]];
}

- (void)passData:(id)data
{
    NSDictionary *dicResult = data[@"data"];
    NSArray *array = dicResult[@"list"];
    if (self.isFootRefresh == YES) {
        NSMutableArray *mutArr2 = [NSMutableArray arrayWithArray:self.mutArray];
        for (NSDictionary *dict in array) {
            CLCarModel *model = [[CLCarModel alloc] initWithDict:dict];
            [mutArr2 addObject:model];
        }
        self.mutArray = mutArr2;
    } else{
        self.mutArray = nil;
        for (NSDictionary *dict in array) {
            CLCarModel *model = [[CLCarModel alloc] initWithDict:dict];
            [self.mutArray addObject:model];
        }
    }
    [self.tableView reloadData];
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLCarModel *model = self.mutArray[indexPath.row];
    NSArray *array = [model.picCover componentsSeparatedByString:@";"];
    if (array.count == 3) {
        CLNewSixTableViewCell *cell = [CLNewSixTableViewCell cellWithTableView:tableView];
        cell.carModel = self.mutArray[indexPath.row];
        return cell;
    }else {
        CLNewsTableViewCell *cell = [CLNewsTableViewCell cellWithTableView:tableView];
        cell.carModel = self.mutArray[indexPath.row];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLCarModel *model = self.mutArray[indexPath.row];
    
    NSArray *array = [model.picCover componentsSeparatedByString:@";"];
    if (array.count == 3) {
        return 110;
    } else{
        return 80;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLCarModel *carModel = self.mutArray[indexPath.row];
    CLCarWebViewController *web = [[CLCarWebViewController alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://h5.ycapp.yiche.com/news/%@.html?plat=2&appver=6.7&ts=20160111164821",carModel.newsId];
    web.urlStr = url;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:web];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark - UIViewControllerTransitioningDelegate
//这个方法是说明哪个控制器控制presentatingController、presentatedController
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CoustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

// 自定义PresentedController的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{   CLCarAnimatedTransitioning *anim = [[CLCarAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLCarAnimatedTransitioning *anim = [[CLCarAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}



@end
