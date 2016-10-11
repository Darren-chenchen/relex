//
//  CLCfDetailViewController.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//http://cf.anzogame.com/mobiles/item/23346?dw=320&i_=af645182ba22f4f731c50e8ce61d12fa&t_=1449653719&p_=13502&v_=1010003&d_=ios&dv_=9.1

#import "CLCfDetailViewController.h"
#import "CLCfModel.h"

@interface CLCfDetailViewController ()

@end

@implementation CLCfDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str1 =[NSString stringWithFormat:@"http://cf.anzogame.com/mobiles/item/%@?dw=320&i_=af645182ba22f4f731c50e8ce61d12fa&t_=1449653719&p_=13502&v_=1010003&d_=ios&dv_=9.1",self.cfModel.ids];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:str1];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
