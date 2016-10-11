//
//  CLNewsViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//http://lib.wap.zol.com.cn/ipj/docList/?v=4.0&class_id=0&isReviewing=NO&last_time=2015-12-07%2010%3A14&page=1&retina=1&vs=iph440

#import "CLNewsViewController.h"
#import <MJRefresh.h>
#import "Request.h"
#import "CLNewsModel.h"
#import "CLNewSixTableViewCell.h"
#import "CLNewsTableViewCell.h"
#import "CLNewWebViewController.h"
#import "CoustomPresentationController.h"
#import "CLAnimatedTransitioning.h"
#import <AFNetworking.h>
#import "LoginViewController.h"

@interface CLNewsViewController ()<RequestDelegate,UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate,CLNewsTableViewCellDelegate>

@property (nonatomic,strong) NSArray *Arr;
@property (nonatomic,strong) NSMutableArray *Arr2;

@property(nonatomic,copy) NSString *urlStr;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) int page;

@property (nonatomic,assign) BOOL isFootRefresh;

@property (nonatomic,strong) NSMutableArray *favArr;

@end

@implementation CLNewsViewController

- (NSArray *)Arr
{
    if (_Arr == nil) {
        _Arr = [NSArray array];
    }
    return _Arr;
}

- (NSMutableArray *)Arr2
{
    if (_Arr2 == nil) {
        _Arr2 = [NSMutableArray array];
    }
    return _Arr2;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self netRequest];
    self.navigationItem.title = @"科技新闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
    
    self.page = 1;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(foot)];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(head)];
    [tableView.mj_header beginRefreshing];

}
- (NSMutableArray *)favArr
{
    if (_favArr == nil) {
        _favArr = [NSMutableArray array];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newFav.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];   //将对象加入到path路径对应的文件中,archive归档
        _favArr = array;
    }
    return _favArr;
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
        self.page++;
        [self netRequest];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    });
    
}

- (void)netRequest
{
    Request *request = [[Request alloc] init];
    request.delegate = self;
    request.type = @"text/html";
    NSString *urlStr1 = [NSString stringWithFormat:@"%d",self.page];
    NSString *urlStr2 = @"http://lib.wap.zol.com.cn/ipj/docList/?v=4.0&class_id=0&isReviewing=NO&last_time=2015-12-07%";
    NSString *urlStr3 = @"2010%";
    NSString *urlStr5 = [NSString stringWithFormat:@"3A14&page=%@",urlStr1];
    NSString *urlStr6 = @"&retina=1&vs=iph440";
    NSString *pageStr = [NSString stringWithFormat:@"%@%@%@%@",urlStr2,urlStr3,urlStr5,urlStr6];
    
    [request  requestDataFromUrlString: pageStr];
}

- (void)passData:(id)data
{
    NSArray *array = data[@"list"];
    if (self.isFootRefresh == YES) {
        NSMutableArray *mutArr2 = [NSMutableArray arrayWithArray:self.Arr];
        for (NSDictionary *dict in array) {
            CLNewsModel *model = [[CLNewsModel alloc] initWithDict:dict];
            [mutArr2 addObject:model];
        }
        self.Arr = mutArr2;
    } else {
        self.Arr = nil;
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CLNewsModel *model = [[CLNewsModel alloc] initWithDict:dict];
            [mutArr addObject:model];
        }
        self.Arr = [NSArray arrayWithArray:mutArr];
    }
    NSArray *array2 = data[@"pics"];
    for (NSDictionary *dicts in array2) {
        CLNewsModel *model = [[CLNewsModel alloc] initWithDict:dicts];
        [self.Arr2 addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.Arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLNewsModel *model = self.Arr[indexPath.row];
    
    if ([model.type isEqualToString:@"6"]) {
        CLNewSixTableViewCell *cell = [CLNewSixTableViewCell cellWithTableView:tableView];
        cell.model = self.Arr[indexPath.row];
        return cell;
    }else {
        CLNewsTableViewCell *cell = [CLNewsTableViewCell cellWithTableView:tableView];
        cell.model = self.Arr[indexPath.row];
        //为了保证下次登录时能够显示已经收藏的新闻，就从沙盒中取出已经收藏的新闻，并将它们的收藏状态变为selected
        for (CLNewsModel *model in self.favArr) {
            if ([model.stitle isEqualToString:cell.model.stitle]) {
                cell.model.isSelected = YES;
                cell.favriteBtn.selected = YES;
            }
        }
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - CLNewsTableViewCellDelegate
/**点击收藏，刷新tableview*/
- (void)TableViewReloadData
{
    [self.tableView reloadData];
}
/**再次点击收藏，收藏取消，即把沙盒中的该条内容删除*/
- (void)clickFavMakeTableViewReloadData:(CLNewsModel *)model
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newFav.plist"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];   //将对象加入到path路径对应的文件中,archive归档
    NSMutableArray *mutarr = [NSMutableArray array];
    for (CLNewsModel *model1 in array) {
        if (![model1.stitle isEqualToString:model.stitle]) {
            [mutarr addObject:model1];
        }
    }
    self.favArr = mutarr;  // 将最新的沙盒中内容给self.favArr，以便刷新tableview时它是最新的数据
    [NSKeyedArchiver archiveRootObject:mutarr toFile:path];
    [self.tableView reloadData];
}
- (void)jumpToLoginController
{
    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLNewsModel *model = self.Arr[indexPath.row];
    
    CLNewWebViewController *web = [[CLNewWebViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:web];
    web.urlStr = model.url;
    // 自定义样式
    nav.modalPresentationStyle = UIModalPresentationCustom;
    nav.transitioningDelegate = self;
    [self presentViewController:nav animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLNewsModel *model = self.Arr[indexPath.row];
    
    if ([model.type isEqualToString:@"6"]) {
        return 110;
    } else{
        return 80;
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
{   CLAnimatedTransitioning *anim = [[CLAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLAnimatedTransitioning *anim = [[CLAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}



@end
