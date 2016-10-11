//
//  CLCfWebViewController.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLCfWebViewController.h"
#import "CLCfModel.h"
#import "Request.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CLCfWebViewController ()<RequestDelegate>
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CLCfWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.video_url]];
    self.playerController.view.frame = self.view.frame;//视频视图大小
    [self.view addSubview:self.playerController.view];//把视频界面加到主界面上
    [self.playerController play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
}
- (void)didFinish {
    //    NSLog(@"播放完成");
}

@end
