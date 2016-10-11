//
//  MeViewController.m
//  Relax
//
//  Created by Darren on 16/1/23.
//  Copyright © 2016年 darren. All rights reserved.
//

#define alreadyLoginIcon [UIImage circleImageWithName:@"meicon2" borderWidth:10 borderColor:[UIColor orangeColor]]
#define notLoginIcon [UIImage circleImageWithName:@"meicon" borderWidth:10 borderColor:[UIColor whiteColor]]

#import "MeViewController.h"
#import "LoginViewController.h"
#import "CLFavoriteViewController.h"
#import "CLFavoriteAnimatedTransitioning.h"
#import "CoustomPresentationController.h"
#import "NewsFavViewController.h"
#import "GameFavViewController.h"
#import "UIImage+MJ.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDK/ShareSDK.h>

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak) UIImageView *imageView;  // tableview头部空间
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,weak) UILabel *userLable;  // 显示账号的lable
@property (nonatomic,weak) UIImageView *loginView;// 圆形的头像
@property (nonatomic,weak) UIButton *btn;//显示“登录”的 btn
@property (nonatomic,weak) UIButton *btnExit;// 退出按钮
@property (nonatomic,weak) UIButton *cameraBtn;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];

    // 用户登录后下次再登录，用户名直接显示
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"];
    NSString *userStr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    self.userLable.text = userStr;
    if (self.userLable.text) {
        [self.btn setTitle:@"" forState:UIControlStateNormal];
        self.btn.userInteractionEnabled = NO;
        self.btnExit.hidden = NO;
        NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 2.2.获得文件的全路径
        NSString *path2 = [doc2 stringByAppendingPathComponent:@"iconImage.data"];
        // 2.3.将对象归档
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:path2];
        UIImage *image = [dic objectForKey:self.userLable.text];
        if (image) {
            self.loginView.image = image;
            self.loginView.layer.cornerRadius = 50;
            self.loginView.layer.borderWidth = 5;
            self.loginView.layer.borderColor = [UIColor orangeColor].CGColor;
            self.loginView.layer.masksToBounds = YES;
        } else {
            self.loginView.image = alreadyLoginIcon;
        }

    } else
    {
        self.btnExit.hidden = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotic:) name:@"UserLable" object:nil];
    // 短信验证码登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSMSNotic:) name:@"SMS" object:nil];
    
    if (self.userLable.text==nil) {
        self.cameraBtn.hidden = YES;
    } else {
        self.cameraBtn.hidden = NO;
    }
}

- (void)getSMSNotic:(NSNotification *)notic
{
    self.userLable.text = notic.object;
    if (self.userLable.text) {
        [self.btn setTitle:@"" forState:UIControlStateNormal];
        self.loginView.image = alreadyLoginIcon;
        self.btn.userInteractionEnabled = NO;
        self.btnExit.hidden = NO;
    } else
    {
        self.btnExit.hidden = YES;
    }
}

- (void)getNotic:(NSNotification *)notic
{
    // 登录后显示照相机
    self.cameraBtn.hidden = NO;
    
    self.userLable.text = notic.object;
    [self.btn setTitle:@"" forState:UIControlStateNormal];
    NSString *doc2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path2 = [doc2 stringByAppendingPathComponent:@"iconImage.data"];
    // 2.3.将对象归档
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:path2];
    UIImage *image = [dic valueForKey:self.userLable.text];
    if (image) {
        self.loginView.image = image;
        self.loginView.layer.cornerRadius = 50;
        self.loginView.layer.borderWidth = 5;
        self.loginView.layer.borderColor = [UIColor orangeColor].CGColor;
        self.loginView.layer.masksToBounds = YES;
    } else {
        self.loginView.image = alreadyLoginIcon;
    }
    self.btn.userInteractionEnabled = NO;
    self.btnExit.hidden = NO;
    // 将用户名存入沙盒，以便下次登录时就不用重新登录了
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"];
    [NSKeyedArchiver archiveRootObject:self.userLable.text toFile:path];
}

// 移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[@"笑话收藏",@"新闻收藏",@"游戏收藏"];
    }
    return _array;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new]; // 去掉多余的横线
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 200)];
    imageView.image = [UIImage imageNamed:@"1"];
    imageView.userInteractionEnabled= YES;
    self.imageView = imageView;
    [tableView addSubview:imageView];
    
    UIImageView *loginView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
    loginView.center = CGPointMake(self.view.frame.size.width*0.5, imageView.frame.size.height*0.5-200);
    loginView.image = notLoginIcon;
    loginView.userInteractionEnabled = YES;
//    loginView.layer.cornerRadius = 50;
//    loginView.layer.borderWidth = 5;
//    loginView.layer.borderColor = [UIColor whiteColor].CGColor;
//    loginView.layer.masksToBounds = YES;
    [tableView addSubview:loginView];
    self.loginView = loginView;
    // 显示“登录”
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0.5*(loginView.frame.size.width-50), 0.5*(loginView.frame.size.height-50), 50, 50)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [loginView addSubview:btn];
    self.btn = btn;
    [btn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    // 显示用户名
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    lable.center = CGPointMake(self.view.frame.size.width*0.5, imageView.frame.size.height*0.5-120);
    lable.textColor = [UIColor orangeColor];
//    lable.backgroundColor = [UIColor redColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [tableView addSubview:lable];
    self.userLable = lable;
    
    // 退出当前账号
    UIButton *btnExit = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5+110, imageView.frame.size.height*0.5-135, 50, 30)];
    [btnExit setTitle:@"退出" forState:UIControlStateNormal];
    [btnExit setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [tableView addSubview:btnExit];
    self.btnExit = btnExit;
    [btnExit addTarget:self action:@selector(clickbtnExit) forControlEvents:UIControlEventTouchUpInside];
    
    //分享按钮
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5+125, imageView.frame.size.height*0.5-250, 25, 25)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"shareout"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(clickShareBtn) forControlEvents:UIControlEventTouchUpInside];
//    [tableView addSubview:shareBtn];
    
    // 设置用户头像
    UIButton *camera = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-15, -180, 30, 30)];
    [camera setBackgroundImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(clcikCamera) forControlEvents:UIControlEventTouchUpInside];
    self.cameraBtn = camera;
    if (!self.userLable.text) {
        camera.hidden = YES;
    } else {
        camera.hidden = NO;
    }
    [tableView addSubview:camera];
}

/**点击了照相机*/
- (void)clcikCamera
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImagePickerController *photoController = [[UIImagePickerController alloc] init];
            photoController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            photoController.delegate = self;
            photoController.allowsEditing = YES;//允许编辑
            [self presentViewController:photoController animated:YES completion:nil];
        }
    }];
    UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *camearController = [[UIImagePickerController alloc] init];
            camearController.sourceType = UIImagePickerControllerSourceTypeCamera;
            camearController.delegate = self;
            
            [self presentViewController:camearController animated:YES completion:nil];
        }
    }];
    UIAlertAction *alertAct2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertCon addAction:alertAct];
    [alertCon addAction:alertAct1];
    [alertCon addAction:alertAct2];
    [self presentViewController:alertCon animated:YES completion:nil];

}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];//取到选中的图片, 如果是相机的话，取到拍到的照片
    self.loginView.image = image;
    self.loginView.layer.cornerRadius = 50;
    self.loginView.layer.borderWidth = 5;
    self.loginView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.loginView.layer.masksToBounds = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"iconImage.data"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:image forKey:self.userLable.text];
    // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:dic toFile:path];
}
//保存照片到相册
- (void)saveImage:(UIImage *)image {
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickShareBtn
{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"512.png"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"这个应用还不错，快来看看吧......"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1070843107"]
                                          title:@"累了吗"
                                           type:SSDKContentTypeAuto];
    
    [ShareSDK showShareActionSheet:nil
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];}
}

// 退出当前账号
- (void)clickbtnExit
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"是否退出当前账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAct1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.btn.userInteractionEnabled = YES;
        [self.btn setTitle:@"登录" forState:UIControlStateNormal];
        self.loginView.image = notLoginIcon;
        self.userLable.text = nil;
        //删除沙盒中的账户信息
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"];
        [fileManager removeItemAtPath:path error:nil];
        
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        [userD removeObjectForKey:@"user"];
        [userD removeObjectForKey:@"pwd"];

        // 退出后隐藏退出按钮
        self.btnExit.hidden = YES;
        if (!self.userLable.text) {
            self.cameraBtn.hidden = YES;
        } else {
            self.cameraBtn.hidden = NO;
        }

    }];
    UIAlertAction *alertAct2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertCon addAction:alertAct1];
    [alertCon addAction:alertAct2];
    [self presentViewController:alertCon animated:YES completion:nil];
}

/**点击登录按钮*/
- (void)clickLogin
{
    [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MeID = @"meCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + 200)/2;
    
    if (yOffset < -200) {
        
        CGRect rect = self.imageView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = self.view.frame.size.width + fabs(xOffset)*2;
        
        self.imageView.frame = rect;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if (self.userLable.text) {
            CLFavoriteViewController *favorite = [[CLFavoriteViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
        } else{
            [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
        }
    } else if (indexPath.row == 1){
        if (self.userLable.text) {
            NewsFavViewController *favorite = [[NewsFavViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
            [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
        }
    } else if (indexPath.row == 2){
        if (self.userLable.text) {
            GameFavViewController *favorite = [[GameFavViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favorite];
            nav.modalPresentationStyle = UIModalPresentationCustom;
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
            [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
        }

    }
}
#pragma mark - UIViewControllerTransitioningDelegate
//这个方法是说明哪个控制器控制presentatingController、presentatedController
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CoustomPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

// 自定义PresentedController的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{   CLFavoriteAnimatedTransitioning *anim = [[CLFavoriteAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;  // 自己遵守UIViewControllerAnimatedTransitioning协议
}

// 自定义控制器消失时的动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CLFavoriteAnimatedTransitioning *anim = [[CLFavoriteAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}

@end
