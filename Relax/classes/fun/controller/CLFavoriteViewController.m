//
//  CLFavoriteViewController.m
//  Relax
//
//  Created by Darren on 16/1/13.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLFavoriteViewController.h"
#import "CLFavoriteTableViewCell.h"
#import "funFrameModel.h"
#import "funModel.h"
#import "CLShareView.h"
#import <SVProgressHUD.h>

@interface CLFavoriteViewController ()<UITableViewDataSource,UITableViewDelegate,CLFavoriteTableViewCellDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dateArr;
@property (nonatomic,strong) NSMutableArray *funContentArr;
@end

@implementation CLFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupTableView];
    
    if (self.funContentArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:@"您还没有收藏哦"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (NSMutableArray *)dateArr
{
    if (_dateArr == nil) {
        _dateArr = [NSMutableArray array];
        // 从沙盒中取出存放时间的数组
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"date.data"]];
            for (int i = 0; i<array.count/2.0; i++) {
                [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i];
            }
        _dateArr = array;
    }
    return _dateArr;
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
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

}

- (void)clcikRightBtn
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否清空收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.funContentArr removeAllObjects];
        [self.tableView reloadData];
        self.funContentArr = nil;
        
        // 2.1.获得Documents的全路径
        NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path2 = [doc2 stringByAppendingPathComponent:@"funContent.plist"];
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
    NSString *path2 = [doc2 stringByAppendingPathComponent:@"funContent.plist"];
    [NSKeyedArchiver archiveRootObject:self.funContentArr toFile:path2];   //将对象加入到path路径对应的文件中,archive归档
}
- (NSMutableArray *)funContentArr
{
    if (_funContentArr == nil) {
        _funContentArr = [NSMutableArray array];
        
        // 从沙盒中取出数组
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"funContent.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // 数组逆序排列。把最近收藏的放在最前面
        for (int i = 0; i<array.count/2.0; i++) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i];
        }
        _funContentArr = array;
    }
    return _funContentArr;
}

- (void)clcikCancel
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.funContentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLFavoriteTableViewCell *cell = [CLFavoriteTableViewCell cellWithTableView:tableView];
    funFrameModel *model = self.funContentArr[indexPath.row];
    cell.frameModel = model;
    cell.delagate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没有阴影显示
    
    NSDate *date = self.dateArr[indexPath.row];
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"]; // 2014-03-21 
    //把格式与我们的日期关联起来
    NSString * str = [f stringFromDate:date];
    cell.funLable.text = [NSString stringWithFormat:@"收藏日期:%@",str];
    return cell;
}
/**cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    funFrameModel *frameModel = self.funContentArr[indexPath.row];
    return frameModel.cellHeight;
}

// 点击分享按钮  代理方法
- (void)passModelForShare:(funFrameModel *)funFrameModel
{
    NSString *string = funFrameModel.funModel.content;
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    CLShareView *shareView2 = [[CLShareView alloc] init];
    shareView2.content = string;
    [win addSubview:shareView2];
    shareView2.btnSelected = ^{
        
    };
}

- (void)passModelForDelete:(funFrameModel *)frameModel
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否要删除该条收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.funContentArr removeObject:frameModel];
        [self.tableView reloadData];
        
        // 2.1.获得Documents的全路径
        NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path2 = [doc2 stringByAppendingPathComponent:@"funContent.plist"];
        [NSKeyedArchiver archiveRootObject:self.funContentArr toFile:path2];   //将对象加入到path路径对应的文件中,archive归档

    }];
    UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon addAction:alertAct];
    [alertCon addAction:alertAct1];
    [self presentViewController:alertCon animated:YES completion:nil];
}
@end
