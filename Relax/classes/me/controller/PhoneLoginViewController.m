//
//  PhoneLoginViewController.m
//  Relax
//
//  Created by Darren on 16/1/26.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "MeViewController.h"

@interface PhoneLoginViewController ()
- (IBAction)back;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *SMSpwd;
@property (weak, nonatomic) IBOutlet UIButton *getSmsPwd;
- (IBAction)clickGetSmsBtn;
- (IBAction)clcikLogin;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int currentNum;
@end

@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.layer.masksToBounds = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**获取验证码*/
- (IBAction)clickGetSmsBtn {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber.text zone:@"86"
customIdentifier:nil
result:^(NSError *error) {
    if (!error) {
        NSLog(@"获取验证码成功");
    } else {
        NSLog(@"错误信息：%@",error);
    }
   }];
    
    self.currentNum = 60;
    [self.getSmsPwd setTitle:[NSString stringWithFormat:@"%d",self.currentNum] forState:UIControlStateNormal];
    self.getSmsPwd.userInteractionEnabled = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
}

- (void)count
{
    self.currentNum --;
    [self.getSmsPwd setTitle:[NSString stringWithFormat:@"%d",self.currentNum] forState:UIControlStateNormal];
    if (self.currentNum == 1) {
        self.getSmsPwd.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;
        [self.getSmsPwd setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}


- (IBAction)clcikLogin {
    if (self.phoneNumber.text.length != 11) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"请输入11位手机号码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertCon addAction:alertAct1];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    [SMSSDK commitVerificationCode:self.SMSpwd.text phoneNumber:self.phoneNumber.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {

            MeViewController *me = [[MeViewController alloc] init];
            [self presentViewController:me animated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SMS" object:self.phoneNumber.text];
        }
        else
        {
            NSLog(@"错误信息:%@",error);
        }
    }];
    
    [self.view endEditing:YES];
}
@end
