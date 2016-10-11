//
//  CLNewWebViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLNewWebViewController.h"

@interface CLNewWebViewController ()

@end

@implementation CLNewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"取消";
    // 跳转到对应的网页
    [self setupWebView];
    
    // 设置导航栏
    [self setupNav];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickCancel)];
}

- (void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**设置WebVIew*/
- (void)setupWebView
{
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];

}


@end
