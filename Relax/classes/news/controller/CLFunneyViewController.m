//
//  CLFunneyViewController.m
//  Relax
//
//  Created by Darren on 16/1/11.
//  Copyright © 2016年 darren. All rights reserved.
//http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?isNotModified=0&useType=iPhone&adapterNo=6.11.1&showType=double&positionId=&channelId=100391-0
//http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?isNotModified=0&useType=iPhone&adapterNo=6.11.1&showType=double&positionId=6689396&channelId=100391-0
//http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?isNotModified=0&useType=iPhone&adapterNo=6.11.1&showType=double&positionId=6674692&channelId=100391-0
//http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?isNotModified=0&useType=iPhone&adapterNo=6.11.1&showType=double&positionId=6670682&channelId=100391-0
#import "CLFunneyViewController.h"
#import <MJRefresh.h>
#import "Request.h"
#import "CLVidioListModel.h"
#import "CLFunneyModel.h"
#import "CLNewsTableViewCell.h"
#import "CLFunWebViewController.h"
#import "CoustomPresentationController.h"
#import "CLFunneyAnimatedTransitioning.h"

@interface CLFunneyViewController ()<UITableViewDataSource,UITableViewDelegate,RequestDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) NSMutableArray *mutArray;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,copy) NSString *positionStr;
@property (nonatomic,assign) BOOL isFootRefresh;
@end

@implementation CLFunneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"娱乐新闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    self.positionStr = @"positionId=";
    [self netRequest];
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
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(head)];}

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
        CLFunneyModel *model = [self.mutArray lastObject];
        NSString *str = [model.itemIdList lastObject];
        self.positionStr = [NSString stringWithFormat:@"positionId=%@",str];
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
    [request  requestDataFromUrlString:[NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/recommendGroupByTeamid.do?isNotModified=0&useType=iPhone&adapterNo=6.11.1&showType=double&%@&channelId=100391-0",self.positionStr]];
}

- (void)passData:(id)data
{
    NSArray *array = data[@"bodyList"];
        if (self.isFootRefresh == YES) {
        NSMutableArray *mutArr2 = [NSMutableArray arrayWithArray:self.mutArray];
        for (NSDictionary *dict in array) {
            CLFunneyModel *model = [[CLFunneyModel alloc] initWithDict:dict];
            [mutArr2 addObject:model];
        }
        self.mutArray = mutArr2;
    } else{
        self.mutArray = nil;
        for (NSDictionary *dict in array) {
            CLFunneyModel *model = [[CLFunneyModel alloc] initWithDict:dict];
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
    CLNewsTableViewCell *cell = [CLNewsTableViewCell cellWithTableView:tableView];
    CLFunneyModel *funModel = self.mutArray[indexPath.row];
    cell.funModel = funModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLFunneyModel *funModel = self.mutArray[indexPath.row];
    for (CLVidioListModel *model in funModel.videoList) {
        CLFunWebViewController *web = [[CLFunWebViewController alloc] init];
        web.urlStr = [NSString stringWithFormat:@"http://vcsp.ifeng.com/vcsp/appData/getGuidRelativeVideoList.do?pageSize=20&guid=%@",model.guid];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:web];
        nav.transitioningDelegate = self;
        nav.modalPresentationStyle = UIModalPresentationCustom;
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
{   CLFunneyAnimatedTransitioning *anim = [[CLFunneyAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLFunneyAnimatedTransitioning *anim = [[CLFunneyAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}



@end
