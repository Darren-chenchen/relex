//
//  CLNewMainViewController.m
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLNewMainViewController.h"
#import "CLNewsViewController.h"
#import "CLNBAViewController.h"
#import "CLCarViewController.h"
#import "CLFunneyViewController.h"
#import "CLMilitaryViewController.h"

@interface CLNewMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *categoryArr;
@end

@implementation CLNewMainViewController

- (NSArray *)categoryArr
{
    if (_categoryArr == nil) {
        _categoryArr = @[@"科技新闻",@"NBA资讯",@"汽车资讯",@"娱乐播报",@"军事速递"];
    }
    return _categoryArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻汇总";
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.categoryArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CLNewsViewController *new = [[CLNewsViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:new];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    } else if(indexPath.row==1){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CLNBAViewController alloc] init]];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    } else if(indexPath.row==2){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CLCarViewController alloc] init]];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    } else if(indexPath.row == 3){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CLFunneyViewController alloc] init]];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    } else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[CLMilitaryViewController alloc] init]];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:nav animated:YES completion:nil];
    }
}


@end
