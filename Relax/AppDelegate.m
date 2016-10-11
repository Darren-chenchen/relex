//
//  AppDelegate.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "AppDelegate.h"
#import "CLTabBarViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SDImageCache.h"
#import "SDWebImageManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <SMS_SDK/SMSSDK.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
@interface AppDelegate ()
@property (strong, nonatomic) UIView *ADView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[CLTabBarViewController alloc] init];
    // 4.监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            
                [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [SVProgressHUD showInfoWithStatus:@"您目前不在WiFi环境，请在WiFi环境下观看视频"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];

                });
            
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
#pragma mark - shareSDK
    [ShareSDK registerApp:@"f109cb4e5028"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSMS)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
            default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1761000454"
                                           appSecret:@"5ec7659fb98cefcc72c9092615ab4e2d"
                                         redirectUri:@"http://sns.whalecloud.com/sina2/callback"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx5076ee2f2a49f3ea"
                                       appSecret:@"1dc9b22d6c5a07b95cdf02da8e340ea9"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1104976467"
                                      appKey:@"Nlf38gsPZHZMwX1b"
                                    authType:SSDKAuthTypeBoth];
                 break;
            default:
                 break;
         }
     }];
#pragma mark - 友盟分享
    // 1.友盟分享
//    [UMSocialData setAppKey:@"568f861567e58e5246000929"];
    //2.qq
//    [UMSocialQQHandler setQQWithAppId:@"1104976467" appKey:@"Nlf38gsPZHZMwX1b" url:@"http://www.darren.com"];
    //3.微信
//    [UMSocialWechatHandler setWXAppId:@"wxb0b8d7863854356d" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"https://www.darren.com"];
    //4.打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //5.打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
//    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    //对未安装客户端平台进行隐藏(由于苹果审核政策需求)
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, UMShareToQzone,UMShareToQQ]];
#pragma mark - 推送
//    //注册远程推送服务
//    UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    [application registerUserNotificationSettings:notiSettings];
//    
//    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (userInfo) { //点击远程通知启动的程序
//        
//    } else {
//        
//    }
    // 沙盒中存放一个计数器，当用户启动app次数到达一定程度时，就弹出是否给应用评论的选择
    int i = arc4random()%20;  // 随机生成一个随机数
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"countRecord.data"]];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    [arr addObject:[NSString stringWithFormat:@"%d",i]];
    [NSKeyedArchiver archiveRootObject:arr toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"countRecord.data"]];
    
    // 短信验证码
    [SMSSDK registerApp:@"f29a49e938e4"
             withSecret:@"c7f41425f6a7a06a7f38ef0ec1652aed"];
    return YES;
}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
//    NSLog(@"---Token--%@", pToken);
//}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  YES;
//}
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    
//    NSLog(@"Regist fail%@",error);
//}

//// 接受到推送后调用这个方法
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    
//    NSLog(@"userInfo == %@",userInfo);
//    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    [alert show];
//}
//当用户通过其它应用启动本应用时，会回调这个方法，url参数是其它应用调用openURL:方法时传过来的。
#pragma mark - 移除广告View
-(void)removeADView
{
    [self.ADView removeFromSuperview];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

        return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清除之前的缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停下正在进行的下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
