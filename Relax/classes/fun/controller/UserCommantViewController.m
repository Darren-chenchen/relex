//
//  UserCommantViewController.m
//  Relax
//
//  Created by Darren on 16/1/26.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "UserCommantViewController.h"

@interface UserCommantViewController ()
- (IBAction)afterBtn;
- (IBAction)commant;

@end

@implementation UserCommantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)afterBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCover" object:nil];
}

- (IBAction)commant {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCover" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://itunes.apple.com/app/id%@",
                     @"1070843107"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
