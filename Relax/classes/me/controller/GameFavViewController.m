//
//  GameFavViewController.m
//  Relax
//
//  Created by Darren on 16/1/25.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "GameFavViewController.h"
#import "CfTwoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CLCfWebViewController.h"
#import <SVProgressHUD.h>

@interface GameFavViewController ()<UITableViewDelegate,UITableViewDataSource,CfTwoTableViewCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *newsArray;

@end

@implementation GameFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self setupNav];
//    NSLog(@"%@",NSHomeDirectory());
    if (self.newsArray.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"您还没有收藏哦"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    
}
- (void)setupNav
{
    self.navigationItem.title = @"我的收藏";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clcikCancel)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"清空" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(clcikRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)clcikCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clcikRightBtn
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否清空收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.newsArray removeAllObjects];
        [self.tableView reloadData];
        self.newsArray = nil;
        
        // 2.1.获得Documents的全路径
        NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path2 = [doc2 stringByAppendingPathComponent:@"gameFav.plist"];
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        [fileManager removeItemAtPath:path2 error:nil];
    }];
    UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon addAction:alertAct];
    [alertCon addAction:alertAct1];
    [self presentViewController:alertCon animated:YES completion:nil];
    
    // 2.1.获得Documents的全路径
    NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path2 = [doc2 stringByAppendingPathComponent:@"gameFav.plist"];
    [NSKeyedArchiver archiveRootObject:self.newsArray toFile:path2];   //将对象加入到path路径对应的文件中,archive归档
}


- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [NSMutableArray array];
        
        // 从沙盒中取出数组
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"gameFav.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // 数组逆序排列。把最近收藏的放在最前面
        for (int i = 0; i<array.count/2.0; i++) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i];
        }
        _newsArray = array;
    }
    return _newsArray;
}


/**初始化tableView*/
- (void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    tableview.tableFooterView = [UIView new]; // 去掉多余的横线
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    CfTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CfTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.Favmodel = self.newsArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)clickFavMakeTableViewReloadData:(CLCfModel *)model
{
    [self.newsArray removeObject:model];
    [self.tableView reloadData];
}
/**cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLCfModel *model = self.newsArray[indexPath.row];
    
    CLCfWebViewController *web = [[CLCfWebViewController alloc] init];
    web.model = model;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)passModelForDelete:(CLCfModel *)model
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否要删除该条收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.newsArray removeObject:model];
        [self.tableView reloadData];
        
        // 2.1.获得Documents的全路径
        NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path2 = [doc2 stringByAppendingPathComponent:@"gameFav.plist"];
        [NSKeyedArchiver archiveRootObject:self.newsArray toFile:path2];   //将对象加入到path路径对应的文件中,archive归档
        
    }];
    UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon addAction:alertAct];
    [alertCon addAction:alertAct1];
    [self presentViewController:alertCon animated:YES completion:nil];
}
@end
