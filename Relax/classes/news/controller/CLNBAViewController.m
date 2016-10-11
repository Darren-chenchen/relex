//
//  CLNBAViewController.m
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//
//http://platform.sina.com.cn/sports_client/feed?ad=1&pos=nba&sport_tour=nba&__os__=iphone&partner=clear&pdps_params={"app":"3.2.0","timestamp":"1452319566","osv":"9.2","targeting":{},"os":"ios","size":["640*104"],"device_type":"4","connection_type":"1","ip":"192.168.1.101","make":"apple","device_id":"6adaa4452a8b4c5ab694f167dc1212d9","model":"iphone7,2","carrier":"中国电信","name":"cn.com.sina.newssports"}&feed_id=653&__version__=3.2.0&client_weibouid=&f=stitle,wapsummary,img,images,comment_show,comment_total,ctime,video_info&client_deviceid=ea636e803fb7ca97ea250f9d6dee1648&app_key=2923419926
//http://platform.sina.com.cn/sports_client/feed?ad=1&pos=nba&sport_tour=nba&__os__=iphone&partner=clear&pdps_params=%7B%0A%20%20%22app%22%20%3A%20%7B%0A%20%20%20%20%22version%22%20%3A%20%223.2.0%22%2C%0A%20%20%20%20%22timestamp%22%20%3A%20%221452345277%22%2C%0A%20%20%20%20%22osv%22%20%3A%20%229.2%22%2C%0A%20%20%20%20%22targeting%22%20%3A%20%7B%0A%0A%20%20%20%20%7D%2C%0A%20%20%20%20%22os%22%20%3A%20%22ios%22%2C%0A%20%20%20%20%22size%22%20%3A%20%5B%0A%20%20%20%20%20%20%22640%2A104%22%0A%20%20%20%20%5D%2C%0A%20%20%20%20%22device_type%22%20%3A%20%224%22%2C%0A%20%20%20%20%22connection_type%22%20%3A%20%221%22%2C%0A%20%20%20%20%22ip%22%20%3A%20%22192.168.1.101%22%2C%0A%20%20%20%20%22make%22%20%3A%20%22apple%22%2C%0A%20%20%20%20%22device_id%22%20%3A%20%226adaa4452a8b4c5ab694f167dc1212d9%22%2C%0A%20%20%20%20%22model%22%20%3A%20%22iphone7%2C2%22%2C%0A%20%20%20%20%22carrier%22%20%3A%20%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%0A%20%20%20%20%22name%22%20%3A%20%22cn.com.sina.newssports%22%0A%20%20%7D%0A%7D&feed_id=653&__version__=3.2.0&client_weibouid=&f=stitle,wapsummary,img,images,comment_show,comment_total,ctime,video_info&client_deviceid=ea636e803fb7ca97ea250f9d6dee1648&app_key=2923419926
//http://platform.sina.com.cn/sports_client/feed?ad=1&pos=nba&sport_tour=nba&__os__=iphone&partner=&pdps_params=%7B%0A%20%20%22app%22%20%3A%20%7B%0A%20%20%20%20%22version%22%20%3A%20%223.2.0%22%2C%0A%20%20%20%20%22timestamp%22%20%3A%20%221452345327%22%2C%0A%20%20%20%20%22osv%22%20%3A%20%229.2%22%2C%0A%20%20%20%20%22targeting%22%20%3A%20%7B%0A%0A%20%20%20%20%7D%2C%0A%20%20%20%20%22os%22%20%3A%20%22ios%22%2C%0A%20%20%20%20%22size%22%20%3A%20%5B%0A%20%20%20%20%20%20%22640%2A104%22%0A%20%20%20%20%5D%2C%0A%20%20%20%20%22device_type%22%20%3A%20%224%22%2C%0A%20%20%20%20%22connection_type%22%20%3A%20%221%22%2C%0A%20%20%20%20%22ip%22%20%3A%20%22192.168.1.101%22%2C%0A%20%20%20%20%22make%22%20%3A%20%22apple%22%2C%0A%20%20%20%20%22device_id%22%20%3A%20%226adaa4452a8b4c5ab694f167dc1212d9%22%2C%0A%20%20%20%20%22model%22%20%3A%20%22iphone7%2C2%22%2C%0A%20%20%20%20%22carrier%22%20%3A%20%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%0A%20%20%20%20%22name%22%20%3A%20%22cn.com.sina.newssports%22%0A%20%20%7D%0A%7D&feed_id=653&ctime=1452312596&__version__=3.2.0&client_weibouid=&f=stitle,wapsummary,img,images,comment_show,comment_total,ctime,video_info&client_deviceid=ea636e803fb7ca97ea250f9d6dee1648&app_key=2923419926
//http://platform.sina.com.cn/sports_client/feed?ad=1&pos=nba&sport_tour=nba&__os__=iphone&partner=&pdps_params=%7B%0A%20%20%22app%22%20%3A%20%7B%0A%20%20%20%20%22version%22%20%3A%20%223.2.0%22%2C%0A%20%20%20%20%22timestamp%22%20%3A%20%221452346636%22%2C%0A%20%20%20%20%22osv%22%20%3A%20%229.2%22%2C%0A%20%20%20%20%22targeting%22%20%3A%20%7B%0A%0A%20%20%20%20%7D%2C%0A%20%20%20%20%22os%22%20%3A%20%22ios%22%2C%0A%20%20%20%20%22size%22%20%3A%20%5B%0A%20%20%20%20%20%20%22640%2A104%22%0A%20%20%20%20%5D%2C%0A%20%20%20%20%22device_type%22%20%3A%20%224%22%2C%0A%20%20%20%20%22connection_type%22%20%3A%20%221%22%2C%0A%20%20%20%20%22ip%22%20%3A%20%22192.168.1.101%22%2C%0A%20%20%20%20%22make%22%20%3A%20%22apple%22%2C%0A%20%20%20%20%22device_id%22%20%3A%20%226adaa4452a8b4c5ab694f167dc1212d9%22%2C%0A%20%20%20%20%22model%22%20%3A%20%22iphone7%2C2%22%2C%0A%20%20%20%20%22carrier%22%20%3A%20%22%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1%22%2C%0A%20%20%20%20%22name%22%20%3A%20%22cn.com.sina.newssports%22%0A%20%20%7D%0A%7D&feed_id=653&ctime=1452289028&__version__=3.2.0&client_weibouid=&f=stitle,wapsummary,img,images,comment_show,comment_total,ctime,video_info&client_deviceid=ea636e803fb7ca97ea250f9d6dee1648&app_key=2923419926
#import "CLNBAViewController.h"
#import "Request.h"
#import "CLNbamodel.h"
#import "CLNBATableViewCell.h"
#import <MJRefresh.h>
#import "CLNBAWebViewController.h"
#import "CLNBAAnimatedTransitioning.h"
#import "CoustomPresentationController.h"

@interface CLNBAViewController ()<UITableViewDelegate,UITableViewDataSource,RequestDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) NSMutableArray *mutArray;
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,assign) BOOL isFootRefresh;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *str3;
@property (nonatomic,copy) NSString *str4;



@end

@implementation CLNBAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NBA";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];

    // 创建tableview
    [self setupTableView];
    
    //自1970年到现在的秒数
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    NSString * timeStr = [NSString stringWithFormat:@"%lld",date];
    self.timeStr = timeStr;
    NSString *str3 = @"partner=clear";
    self.str3 = str3;
    self.str4 = @"";
    [self netRequest];
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
        // 数据的刷新依靠self.str3和self.str4，主要是加载之前的数据实现刷新
        self.str3 = @"partner=";
        int preTime = [self.timeStr intValue]-3600*16; // 加载16小时之前的数据
        NSString *s = [NSString stringWithFormat:@"%d",preTime];
        self.str4 = [NSString stringWithFormat:@"&ctime=%@",s];
        self.timeStr = s;
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
    NSString *str =@"timestamp";
    NSString *str2 = [NSString stringWithFormat:@"%@:%@",str,self.timeStr];
    NSString *str1 = [NSString stringWithFormat:@"http://platform.sina.com.cn/sports_client/feed?ad=1&pos=nba&sport_tour=nba&__os__=iphone&%@&pdps_params=%@&feed_id=653%@&__version__=3.2.0&client_weibouid=&f=stitle,wapsummary,img,images,comment_show,comment_total,ctime,video_info&client_deviceid=ea636e803fb7ca97ea250f9d6dee1648&app_key=2923419926",self.str3,str2,self.str4];
    [request  requestDataFromUrlString:str1];
}

- (void)passData:(id)data
{
    NSDictionary *dicResult = data[@"result"];
    NSDictionary *dicData = dicResult[@"data"];
    NSDictionary *dicFeed = dicData[@"feed"];
    NSArray *array = dicFeed[@"data"];
    if (self.isFootRefresh == YES) {
        NSMutableArray *mutArr2 = [NSMutableArray arrayWithArray:self.mutArray];
        for (NSDictionary *dict in array) {
            CLNbamodel *model = [[CLNbamodel alloc] initWithDict:dict];
            [mutArr2 addObject:model];
        }
        self.mutArray = mutArr2;
    } else{
        self.mutArray = nil;
        for (NSDictionary *dict in array) {
            CLNbamodel *model = [[CLNbamodel alloc] initWithDict:dict];
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
    CLNBATableViewCell *cell = [CLNBATableViewCell cellWithTableView:tableView];
    cell.model = self.mutArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLNbamodel *model = self.mutArray[indexPath.row];
    
    CLNBAWebViewController *web = [[CLNBAWebViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:web];
    web.urlStr = model.url;
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
{   CLNBAAnimatedTransitioning *anim = [[CLNBAAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLNBAAnimatedTransitioning *anim = [[CLNBAAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}

@end
