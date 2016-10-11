//
//  CLGameDetailViewController.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLGameDetailViewController.h"
#import "Request.h"
#import <MJRefresh.h>
#import "DetailHero.h"
#import "CLWebViewController.h"
#import "DetailTableViewCell.h"


@interface CLGameDetailViewController ()<RequestDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *mutArr;
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,assign) int page;

@property (nonatomic,assign) BOOL isHeadRefreash;

@end

@implementation CLGameDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self netRequest];
    [self setupTableView];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)mutArr
{
    if (_mutArr == nil) {
        _mutArr = [NSMutableArray array];
    }
    return _mutArr;
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
    self.isHeadRefreash = YES;
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
    
    NSString *pageStr = [NSString stringWithFormat:@"http://lol.video.luckyamy.com/api/?cat=jieshuo&id=%@&page=%d&ap=lol&ver=1.3",self.hero.ids,self.page];
    
    [request  requestDataFromUrlString: pageStr];
    
}

- (void)passData:(id)data
{
    if (self.isHeadRefreash == YES) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.mutArr];
        for (NSDictionary *dict in data) {
            DetailHero *hero = [DetailHero vedioWithDict:dict];
            [arr addObject:hero];
        }
        self.mutArr = arr;

    } else {
        self.mutArr = nil;
        for (NSDictionary *dict in data) {
            DetailHero *hero = [DetailHero vedioWithDict:dict];
            [self.mutArr addObject:hero];
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
    DetailTableViewCell *cell = [DetailTableViewCell cellWithTableView:tableView];
    
    cell.detalhero = self.mutArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DetailHero *hero = self.mutArr[indexPath.row];
    CLWebViewController *web = [[CLWebViewController alloc] init];
    web.hero = hero;
    [self.navigationController pushViewController:web animated:YES];
}

@end
