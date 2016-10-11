//
//  CLFunWebViewController.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.

// 源头http://vcsp.ifeng.com/vcsp/appData/getGuidRelativeVideoList.do?pageSize=20&guid=01ac0a0c-fbdc-4482-9346-dc6fae2b114e
#import "CLFunWebViewController.h"
#import "Request.h"
#import "VideoPlayView.h"
#import "FullViewController.h"

#define playerW self.view.frame.size.width
#define playerH playerW*9/16
#define playerY (self.view.frame.size.height-playerH)*0.5


@interface CLFunWebViewController ()<RequestDelegate,VideoPlayViewDelegate>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, weak) VideoPlayView *playView;
@property (nonatomic, strong) FullViewController *fullVc;

@end

@implementation CLFunWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"取消";
    // 设置导航栏
    [self setupNav];
    [self netRequest];
    
    // 视频播放器
    VideoPlayView *viewPlayView = [VideoPlayView videoPlayView];
    viewPlayView.frame = CGRectMake(0,playerY,playerW, playerH);
    [self.view addSubview:viewPlayView];
    viewPlayView.delegate = self;
    self.playView = viewPlayView;
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
}

- (void)clickCancel
{
    [self.playView.player pause];
    self.playView.player = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)netRequest
{
    Request *request = [[Request alloc] init];
    request.delegate = self;
    request.type = @"application/json";
    [request  requestDataFromUrlString:self.urlStr];
}

- (void)passData:(id)data
{
    NSArray *array = data[@"guidRelativeVideoInfo"];
    NSDictionary *dict = array[0];
    NSArray *arr = dict[@"files"];
    NSDictionary *dict2 = arr[0];
    NSString *str = dict2[@"mediaUrl"];
    self.url = str;
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:str]];
    [self.playView setPlayerItem:item];
}

#pragma mark - VideoPlayViewDelegate
- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self presentViewController:self.fullVc animated:NO completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            self.playView.frame = CGRectMake(0, playerY,playerW, playerH);
            [self.view addSubview:self.playView];
        }];
    }
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}


@end
