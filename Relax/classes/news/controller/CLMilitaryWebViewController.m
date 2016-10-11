//
//  CLMilitaryWebViewController.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLMilitaryWebViewController.h"
#import "Request.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CLMilitaryWebViewController ()<RequestDelegate>
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CLMilitaryWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"取消";
    // 设置导航栏
    [self setupNav];
    [self netRequest];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
}

- (void)clickCancel
{
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
    
    self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:str]];
    self.playerController.view.frame = self.view.frame;//视频视图大小
    [self.view addSubview:self.playerController.view];//把视频界面加到主界面上
    [self.playerController play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
}
- (void)didFinish {
    //    NSLog(@"播放完成");
}

@end
