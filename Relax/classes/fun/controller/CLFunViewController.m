//
//  CLFunViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLFunViewController.h"
#import "Request.h"
#import "funFrameModel.h"
#import "TCLFunTableViewCell.h"
#import "funModel.h"
#import "CLFavoriteViewController.h"
#import "CoustomPresentationController.h"
#import "CLFavoriteAnimatedTransitioning.h"
#import <ShareSDK/ShareSDK.h>
#import "LoginViewController.h"
#import "UserCommantViewController.h"
#import "CommantPresentationController.h"
#import "AppDelegate.h"
#import "CLCustomButton.h"
#import "CLShareView.h"
#import <MJRefresh.h>

@interface CLFunViewController ()<UITableViewDataSource,UITableViewDelegate,RequestDelegate,TCLFunTableViewCellDelegate,UIActionSheetDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic,weak) UITableView *funTableView;
@property (nonatomic,strong) NSMutableArray *funFrameArray;
@property (nonatomic,assign) int page;
@property (nonatomic,weak) UIButton *favoriteBtn;
@property (nonatomic,copy) NSString *contentStr;
@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) NSMutableArray *funContentArr;
@property (nonatomic,assign,getter=isFootRefrash) BOOL IsFootRefrash;
@property (nonatomic,strong) CALayer *dotLayer;
@property (nonatomic,strong) NSMutableArray *dateArray;

@property (nonatomic,weak) UIView *shareCover;

@property (nonatomic,weak) UILabel *lineLable;
@property (nonatomic,weak) UIButton *currentBtn;
@property (nonatomic,weak) UIView *titlesView;
@property (nonatomic,weak) UIView *indicatorView;
@end

@implementation CLFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    [self setupTableView];
    if (self.type == CLFunTypeOne) {
        [self netRequest];
    } else if (self.type == CLFunTypeTwo){
    
    }
    [self.funTableView.mj_header beginRefreshing];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSMutableArray *)dateArray
{
    if (_dateArray == nil) {
        _dateArray = [NSMutableArray array];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"date.data"]];
        if (array.count!=0) {
            _dateArray = array;
        }
    }
    return _dateArray;
}

- (NSMutableArray *)funContentArr
{
    if (_funContentArr == nil) {
        _funContentArr = [NSMutableArray array];
        // 从沙盒中取出已经存在的数组
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.获得文件的全路径
        NSString *path = [doc stringByAppendingPathComponent:@"funContent.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (array.count!=0) {
        _funContentArr = array; // 如果沙盒中有，就取出
        }
    }
    return _funContentArr;
}
//显示信息
- (void)showmessage
{
    // 1.创建按钮
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - height;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:200/255. green:150/255. blue:80/255. alpha:1];
    btn.frame = CGRectMake(x, y, width, height);
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置按钮文字
    [btn setTitle:@"喜欢段子可以收藏哦" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.userInteractionEnabled = NO;
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    // 3.执行动画
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, height + 1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}


/**懒加载*/
- (NSMutableArray *)funFrameArray
{
    if (_funFrameArray == nil) {
        _funFrameArray = [NSMutableArray array];
    }
    return _funFrameArray;
}

/**网络请求*/
- (void)netRequest
{
    // 2.1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"array.data"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    _funFrameArray = array;
    
    Request *request = [[Request alloc] init];
    request.delegate = self;

    request.type = @"text/html";
//http://m2.qiushibaike.com/article/list/text?count=30&readarticles=%5B114089150%2C114089598%5D&page=1AdID=14491961669474FDE30D21
    NSString *urlStr1 = [NSString stringWithFormat:@"%d",self.page];
    NSString *urlStr2 = @"http://m2.qiushibaike.com/article/list/text?count=30&readarticles=%";
    NSString *urlStr3 = @"5B114089150%";
    NSString *urlStr4 = @"2C114089598%";
    NSString *urlStr5 = [NSString stringWithFormat:@"5D&page=%@",urlStr1];
    NSString *urlStr6 = @"&AdID=14491961669474FDE30D21";
    NSString *pageStr = [NSString stringWithFormat:@"%@%@%@%@%@",urlStr2,urlStr3,urlStr4,urlStr5,urlStr6];
    [request  requestDataFromUrlString: pageStr];
}

#pragma mark - RequestDelegate
- (void)passData:(id)data
{
    if (self.IsFootRefrash == YES) {
        NSMutableArray * mutArr2 = [NSMutableArray arrayWithArray:self.funFrameArray];//获取数组中已有的数据
        NSArray *array = data[@"items"];
        for (NSDictionary *dict in array) {
            funModel *model = [funModel modelWithDict:dict];
            
            funFrameModel *frameModel = [[funFrameModel alloc] init];
            frameModel.funModel = model;
            [mutArr2 addObject:frameModel];
            self.funFrameArray  = mutArr2;
        }
        
    } else {
        self.funFrameArray = nil;
        NSArray *array = data[@"items"];
        for (NSDictionary *dict in array) {
            funModel *model = [funModel modelWithDict:dict];
            
            funFrameModel *frameModel = [[funFrameModel alloc] init];
            frameModel.funModel = model;
            [self.funFrameArray addObject:frameModel];
        }

    }
    //将数组存入沙盒
    // 2.1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"array.data"];
                      // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:self.funFrameArray toFile:path];   //将对象加入到path路径对应的文件中,archive归档
}

/**初始化tableView*/
- (void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.funTableView = tableview;
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(foot)];
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(head)];
    
    tableview.contentInset = UIEdgeInsetsMake(94, 0, 94, 0);
}

- (void)head
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self netRequest];
        
        [self.funTableView reloadData];
        [self.funTableView.mj_header endRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self showmessage];
        });
    });

}

- (void)foot
{
    self.IsFootRefrash = YES;
    // 延迟1秒自动停止
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.page++;
        [self netRequest];
        
        [self.funTableView.mj_footer endRefreshing];
        [self.funTableView reloadData];
    });
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCLFunTableViewCell *cell = [TCLFunTableViewCell cellWithTableView:tableView];
    
    cell.frameModel = self.funFrameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没有阴影显示
    cell.delagate = self;
    return cell;
}

#pragma mark - UITableView代理方法
/**cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    funFrameModel *frameModel = self.funFrameArray[indexPath.row];
    return frameModel.cellHeight;
}

/**长按cell*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.funTableView deselectRowAtIndexPath:indexPath animated:NO];
    CLFavoriteViewController *favorite = [[CLFavoriteViewController alloc] init];
    favorite.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:favorite animated:YES];
}


// 点击分享按钮  代理方法
- (void)passModelForShare:(funFrameModel *)funFrameModel andBUtton:(UIButton *)btn
{
    NSString *string = funFrameModel.funModel.content;
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    CLShareView *shareView2 = [[CLShareView alloc] init];
    shareView2.content = string;
    [win addSubview:shareView2];
    
    shareView2.btnSelected = ^(){
           // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
           CGRect parentRect = [btn convertRect:btn.frame toView:self.view];
            [self JoinFavotiteAnimationWithRect:parentRect];
            NSDate *date = [NSDate date];
            [self.dateArray addObject:date];
            [NSKeyedArchiver archiveRootObject:self.dateArray toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"date.data"]];
            // 从沙盒中取出已经存在的数组
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            // 2.获得文件的全路径
            NSString *path = [doc stringByAppendingPathComponent:@"funContent.plist"];
            NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            self.funContentArr = array;

            // 将最新的数组写入沙盒中
            [self.funContentArr addObject:funFrameModel];
            // 2.1.获得Documents的全路径
            NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            // 2.2.获得文件的全路径
            NSString *path2 = [doc2 stringByAppendingPathComponent:@"funContent.plist"];
            // 2.3.将对象归档
            [NSKeyedArchiver archiveRootObject:_funContentArr toFile:path2];   //将对象加入到path路径对应的文件中,archive归档
    };
}
- (void)text
{
    
}
- (void)clickCancel
{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win.subviews.lastObject removeFromSuperview];
    [self.shareCover removeFromSuperview];
}
/**加入收藏动画*/
- (void)JoinFavotiteAnimationWithRect:(CGRect)parentRect
{
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor colorWithRed:200/255. green:150/255. blue:80/255. alpha:1].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    // 起点
    CGFloat startX = parentRect.origin.x * 0.5 -10;
    CGFloat startY = parentRect.origin.y;
    // 创建一个贝塞尔路径
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线 (起点  中间经过的一点，终点)
    [self.path addCurveToPoint:CGPointMake(0, 0) controlPoint1:CGPointMake(startX, startY) controlPoint2:CGPointMake(-startX*0.5, -startY*0.5)];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.path.CGPath; // 路径是指定好的路径
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.duration = 1.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [_dotLayer addAnimation:animation forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:self.dotLayer afterDelay:0.8f];
}

- (void)removeFromLayer:(CALayer *)layerAnimation{
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 晃动效果的动画
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:0.5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:1];
    shakeAnimation.autoreverses = YES;
    [self.favoriteBtn.layer addAnimation:shakeAnimation forKey:nil];
}

@end
