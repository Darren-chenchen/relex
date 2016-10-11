//
//  CLGameViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLGameViewController.h"
#import "HeroTableViewCell.h"
#import "HeroModel.h"
#import "Request.h"
#import <MJRefresh.h>
#import "CLGameDetailViewController.h"

@interface CLGameViewController ()<RequestDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) int page;
@property (nonatomic,strong) NSMutableArray *mutArr;
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,assign) BOOL isFootRefresh;

@end

@implementation CLGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"LOL";

    self.page = 1;
    [self netRequest];
    
    [self setupTableView];
    
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}

- (NSMutableArray *)mutArr
{
    if (_mutArr == nil) {
        _mutArr = [NSMutableArray array];
    }
    return _mutArr;
}

- (void)netRequest
{
//    // 2.1.获得Documents的全路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    // 2.2.获得文件的全路径
//    NSString *path = [doc stringByAppendingPathComponent:@"LOLarray.data"];
//    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    _mutArr = array;

    Request *request = [[Request alloc] init];
    request.delegate = self;
    
    request.type = @"application/json";
    NSString *pageStr = [NSString stringWithFormat:@"http://lol.video.luckyamy.com/api/?cat=jieshuo&page=%d&ap=lol&ver=1.3",self.page];

    [request  requestDataFromUrlString: pageStr];
    
}
- (void)passData:(id)data
{
    for (NSDictionary *dict in data) {
        HeroModel *hero = [HeroModel vedioWithDict:dict];
        [self.mutArr addObject:hero];
    }
    [self.tableView reloadData];
//    //将数组存入沙盒
//    // 2.1.获得Documents的全路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    // 2.2.获得文件的全路径
//    NSString *path = [doc stringByAppendingPathComponent:@"LOLarray.data"];
//    // 2.3.将对象归档
//    [NSKeyedArchiver archiveRootObject:self.mutArr toFile:path];   //将对象加入到path路径对应的文件中,archive归档
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroTableViewCell *cell = [HeroTableViewCell cellWithTableView:tableView];
    
    cell.hero = self.mutArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HeroModel *hero = self.mutArr[indexPath.row];
    CLGameDetailViewController *detail = [[CLGameDetailViewController alloc] init];
    detail.hero = hero;
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
