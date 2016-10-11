//
//  RegiestViewController.m
//  Relax
//
//  Created by Darren on 16/1/23.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "RegiestViewController.h"

@interface RegiestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *regiestBtn;
- (IBAction)regiest:(UIButton *)sender;
- (IBAction)clickBack;
@property (weak, nonatomic) IBOutlet UITextField *userLable;
@property (weak, nonatomic) IBOutlet UITextField *pwdLable;

@end

@implementation RegiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regiestBtn.layer.cornerRadius = 10;
    self.regiestBtn.layer.masksToBounds = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)regiest:(UIButton *)sender {
    [self.view endEditing:YES];
    
    // 存储账号和密码
    if (self.userLable.text.length!=0&&self.pwdLable.text.length!=0) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.userLable.text forKey:@"user"];
        [user setObject:self.pwdLable.text forKey:@"pwd"];
        [user synchronize];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"成功注册，请登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertCon addAction:alertAct1];
        [self presentViewController:alertCon animated:YES completion:nil];
    } else {
    
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *alertAct2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertCon addAction:alertAct1];
        [alertCon addAction:alertAct2];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
}

- (IBAction)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
