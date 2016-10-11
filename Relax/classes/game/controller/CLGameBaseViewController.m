//
//  CLGameBaseViewController.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLGameBaseViewController.h"
#import "CLGameViewController.h"
#import "CLCfGameViewController.h"

@interface CLGameBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *array;


@end

@implementation CLGameBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.navigationItem.title = @"游戏";
    
    [self setupTableView];
    
    NSArray *arr = @[@"穿越火线",@"英雄联盟"];
    self.array = arr;
    
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = [NSArray array];
    }
    return _array;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        CLGameViewController *game = [[CLGameViewController alloc] init];
        [self.navigationController pushViewController:game animated:YES];
        
    } else if (indexPath.row == 0) {
        CLCfGameViewController *game = [[CLCfGameViewController alloc] init];
        [self.navigationController pushViewController:game animated:YES];
    }
}





@end
