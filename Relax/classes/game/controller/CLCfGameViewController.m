//
//  CLCfGameViewController.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.

#import "CLCfGameViewController.h"
#import "Request.h"
#import "CLCfModel.h"
#import "UIImageView+WebCache.h"
#import "CLCfWebViewController.h"
#import "CLCfDetailViewController.h"
#import "CfOneTableViewCell.h"
#import "CfTwoTableViewCell.h"
#import "LoginViewController.h"
#import <MJRefresh.h>

@interface CLCfGameViewController ()<RequestDelegate,UITableViewDataSource,UITableViewDelegate,CfTwoTableViewCellDelegate>
@property (nonatomic,strong) NSMutableArray *mutArr;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,assign) int page;
@property (nonatomic,assign) BOOL isFootRefresh;

@property (nonatomic,strong) NSMutableArray *favArr;

@end

@implementation CLCfGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"穿越火线";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    [self setupTableView];

    [self netRequest];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)mutArr
{
    if (_mutArr == nil) {
        _mutArr = [NSMutableArray array];
    }
    return _mutArr;
}
- (NSMutableArray *)favArr
{
    if (_favArr == nil) {
        _favArr = [NSMutableArray array];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gameFav.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];   //将对象加入到path路径对应的文件中,archive归档
        _favArr = array;
    }
    return _favArr;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(foot)];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(head)];
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
    
    request.type = @"application/json";
    
    NSString *pageStr = [NSString stringWithFormat:@"http://cf.anzogame.com/apis/rest/ItemsService/lists/?&cattype=news&catid=10002&page=%d&i_=af645182ba22f4f731c50e8ce61d12fa&t_=1449641490&p_=6815&v_=1010003&d_=ios&dv_=9.1&version=0",self.page];
    
    [request  requestDataFromUrlString: pageStr];
    
}

- (void)passData:(id)data
{
    NSArray *array = data[@"data"];
    if (self.isFootRefresh == YES) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.mutArr];
        for (NSDictionary *dict in array) {
            
            CLCfModel *model = [CLCfModel vedioWithDict:dict];
            [arr addObject:model];
        }
        self.mutArr = arr;

    } else {
        self.mutArr = nil;
        for (NSDictionary *dict in array) {

            CLCfModel *model = [CLCfModel vedioWithDict:dict];
            [self.mutArr addObject:model];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLCfModel *model = self.mutArr[indexPath.row];
    if (model.video_url.length == 0) {
        CfOneTableViewCell *cell = [CfOneTableViewCell cellWithTableView:tableView];
        cell.cfmodel = model;
        return cell;
    } else {
        CfTwoTableViewCell *cell = [CfTwoTableViewCell cellWithTableView:tableView];
        cell.cfmodel = model;
        //为了保证下次登录时能够显示已经收藏的新闻，就从沙盒中取出已经收藏的新闻，并将它们的收藏状态变为selected
        for (CLCfModel *model in self.favArr) {
            if ([model.title isEqualToString:cell.cfmodel.title]) {
                cell.cfmodel.isSelected = YES;
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
- (void)clickFavMakeTableViewReloadData:(CLCfModel *)model
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gameFav.plist"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];   //将对象加入到path路径对应的文件中,archive归档
    NSMutableArray *mutarr = [NSMutableArray array];
    for (CLCfModel *model1 in array) {
        if (![model1.title isEqualToString:model.title]) {
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

    CLCfModel *model = self.mutArr[indexPath.row];
    if (model.video_url.length == 0) {
        CLCfDetailViewController *detail = [[CLCfDetailViewController alloc] init];
        detail.cfModel = model;
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        CLCfWebViewController *web = [[CLCfWebViewController alloc] init];
        web.model = model;
        [self.navigationController pushViewController:web animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLCfModel *model = self.mutArr[indexPath.row];
    if (model.video_url.length == 0) {
        return 70;
    } else {
        return 100;
    }
}



@end
