//
//  CLShareView.m
//  Relax
//
//  Created by darren on 16/5/19.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLShareView.h"
#import "CLCustomButton.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>
#import <SVProgressHUD.h>
@interface CLShareView()

/***/
@property (nonatomic,strong) NSArray *imgArr;
@property (nonatomic,strong) NSArray *titleArr;
@end
@implementation CLShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 创建一个阴影
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        cover.backgroundColor = [UIColor blackColor];
        cover.tag = 100;
        cover.alpha = 0.8;
        [win addSubview:cover];
        // 创建一个提示框
        CGFloat tipX = 20;
        CGFloat tipW = cover.frame.size.width - 2*tipX;
        CGFloat tipH = tipW;
        
        UIView *tipViews = [[UIView alloc] initWithFrame:CGRectMake(tipX, CLScreenH, tipW, tipW)];
        tipViews.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        [win addSubview:tipViews];
        [UIView animateWithDuration:0.25 animations:^{
            CGFloat tipY = (CLScreenH-tipW)*0.5;
            tipViews.frame = CGRectMake(tipX, tipY, tipW, tipH);
        } completion:^(BOOL finished) {
            
        }];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, tipViews.frame.size.width, 30)];
        lable.text  =@"分享到";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        [tipViews addSubview:lable];
       Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
        
        if ((![WXApi isWXAppInstalled]&&[QQApiInterface isQQInstalled])&&[messageClass canSendText]) {
            self.imgArr = @[@"QQ",@"QQzoom",@"新浪",@"短信",@"邮件"];
            self.titleArr = @[@"QQ好友",@"QQ空间",@"新浪微博",@"短信",@"收藏"];
        }else if ((![WXApi isWXAppInstalled])&&(![WeiboSDK isWeiboAppInstalled]&&[QQApiInterface isQQInstalled])&&[messageClass canSendText]){
            self.imgArr = @[@"QQ",@"QQzoom",@"短信",@"邮件"];
            self.titleArr = @[@"QQ好友",@"QQ空间",@"短信",@"收藏"];
        } else if (![QQApiInterface isQQInstalled]&&[WXApi isWXAppInstalled]&&[messageClass canSendText]){
            self.imgArr = @[@"weixin",@"朋友圈",@"收藏",@"新浪",@"短信",@"邮件"];
            self.titleArr = @[@"微信好友",@"微信朋友圈",@"微信收藏",@"新浪微博",@"短信",@"收藏"];
        } else if ((![QQApiInterface isQQInstalled])&&(![WXApi isWXAppInstalled])&&[messageClass canSendText]){
            self.imgArr = @[@"新浪",@"短信",@"邮件"];
            self.titleArr = @[@"新浪微博",@"短信",@"收藏"];
        } else if ((![QQApiInterface isQQInstalled])&&([WXApi isWXAppInstalled])&&![messageClass canSendText]){
            self.imgArr = @[@"weixin",@"朋友圈",@"收藏",@"新浪",@"邮件"];
            self.titleArr = @[@"微信好友",@"微信朋友圈",@"微信收藏",@"新浪微博",@"收藏"];
        } else if ((![messageClass canSendText])&&(![QQApiInterface isQQInstalled])&&(![WXApi isWXAppInstalled])){
            self.imgArr = @[@"新浪",@"邮件"];
            self.titleArr = @[@"新浪微博",@"收藏"];
        } else if (([QQApiInterface isQQInstalled])&&([WXApi isWXAppInstalled])&&[WeiboSDK isWeiboAppInstalled]&&[messageClass canSendText]){
            self.imgArr = @[@"QQ",@"QQzoom",@"weixin",@"朋友圈",@"收藏",@"新浪",@"短信",@"邮件"];
            self.titleArr = @[@"QQ好友",@"QQ空间",@"微信好友",@"微信朋友圈",@"微信收藏",@"新浪微博",@"短信",@"收藏"];
        }else if ([QQApiInterface isQQInstalled]&&[WXApi isWXAppInstalled]&&![messageClass canSendText]){
            self.imgArr = @[@"weixin",@"朋友圈",@"收藏",@"新浪",@"邮件"];
            self.titleArr = @[@"微信好友",@"微信朋友圈",@"微信收藏",@"新浪微博",@"收藏"];
        }
       
        for (int i = 0; i < self.titleArr.count; i++) {
            int line = 4;
            CGFloat btnW = tipViews.frame.size.width/line;
            CGFloat btnX = i%line*btnW;
            CGFloat btnY = i/line*btnW;
            UIButton *btnShare = [[CLCustomButton alloc] initWithFrame:CGRectMake(btnX,70 + btnY, btnW, btnW)];
            btnShare.tag = i+100;
            btnShare.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btnShare setTitle:self.titleArr[i] forState:UIControlStateNormal];
            [btnShare setImage:[UIImage imageNamed:self.imgArr[i]] forState:UIControlStateNormal];
            [btnShare addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [tipViews addSubview:btnShare];
        }
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake((tipViews.frame.size.width-50)*0.5, tipViews.frame.size.height - 60, 50, 50)];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [tipViews addSubview:cancelBtn];

    }
    return self;
}

- (void)clickCancel
{
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win.subviews.lastObject removeFromSuperview];
    UIWindow *win2 = [UIApplication sharedApplication].keyWindow;
    [win2.subviews.lastObject removeFromSuperview];
    UIWindow *win3 = [UIApplication sharedApplication].keyWindow;
    [win3.subviews.lastObject removeFromSuperview];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setValue:_content forKey:@"1"];
    [userD synchronize];
}

- (void)clickBtn:(UIButton *)btn
{
    [self initWithBtn:btn];
}
- (void)initWithBtn:(UIButton *)btn
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *str = [userD objectForKey:@"1"];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:str
                                     images:nil
                                        url:nil
                                      title:nil
                                       type:SSDKContentTypeAuto];
    if ([btn.titleLabel.text isEqualToString:@"QQ好友"]) { //QQ
        [ShareSDK share:SSDKPlatformTypeQQ parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }

        }];
    }
    if ([btn.titleLabel.text isEqualToString:@"QQ空间"]) { // QQ 空间
        NSMutableDictionary *shareParams2 = [NSMutableDictionary dictionary];
        [shareParams2 SSDKEnableUseClientShare];
        [shareParams2 SSDKSetupShareParamsByText:str
                                         images:@"logo.png"
                                            url:[NSURL URLWithString:GoToAppS]
                                          title:@"累了吗这款应用还不错哦"
                                           type:SSDKContentTypeAuto];
        [ShareSDK share:SSDKPlatformSubTypeQZone parameters:shareParams2 onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
            
        }];
    }

    if ([btn.titleLabel.text isEqualToString:@"微信好友"]) {
        [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
            
        }];
    }

    if ([btn.titleLabel.text isEqualToString:@"微信朋友圈"]) {
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
            
        }];
    }

    if ([btn.titleLabel.text isEqualToString:@"微信收藏"]) {
        [ShareSDK share:SSDKPlatformSubTypeWechatFav parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
            
        }];
    }

    if ([btn.titleLabel.text containsString:@"新浪微博"]) {

        [ShareSDK share:SSDKPlatformTypeSinaWeibo
                      parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                          if (state == SSDKResponseStateSuccess) {
                              [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                          } else if(state == SSDKResponseStateFail){
                              NSLog(@"%@",error);
                          }
        }];
    }

    if ([btn.titleLabel.text isEqualToString:@"短信"]) {
        [ShareSDK share:SSDKPlatformTypeSMS parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
            
        }];
    }
    
    if ([btn.titleLabel.text isEqualToString:@"收藏"]) {
        [self clickCancel];
         self.btnSelected();
    }
}
@end
