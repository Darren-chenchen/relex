//
//  CLWebViewController.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLWebViewController.h"
#import "DetailHero.h"

@interface CLWebViewController ()

@end

@implementation CLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:self.hero.url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    
    
}

@end
