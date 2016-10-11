//
//  LoginViewController.m
//  Relax
//
//  Created by Darren on 16/1/23.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "LoginViewController.h"
#import "RegiestViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "PhoneLoginViewController.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(UIButton *)sender;
- (IBAction)clickBack;
- (IBAction)clickRegiest;
@property (weak, nonatomic) IBOutlet UITextField *userLable;
@property (weak, nonatomic) IBOutlet UITextField *pwdLable;
- (IBAction)QQlogin;
- (IBAction)phoneLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.layer.masksToBounds = YES;
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    
    // 注册完成后登录
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *user = [userDef objectForKey:@"user"];
    NSString *pwd = [userDef objectForKey:@"pwd"];
    if ([self.userLable.text isEqualToString:user]&&[self.pwdLable.text isEqualToString:pwd]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLable" object:user];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if ([self.userLable.text isEqualToString:@"123"]&&[self.pwdLable.text isEqualToString:@"123"]) {    //测试使用

        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLable" object:@"123"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或者密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertCon addAction:alertAct1];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    
}

- (IBAction)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegiest {
    [self presentViewController:[[RegiestViewController alloc] init] animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (IBAction)QQlogin {
    //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"rawData=%@",user.rawData);
             NSLog(@"昵称=%@",user.nickname);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"头像=%@",user.icon);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}


- (IBAction)phoneLogin {
    
    PhoneLoginViewController *phone = [[PhoneLoginViewController alloc] init];
    [self presentViewController:phone animated:YES completion:nil];
}
@end
