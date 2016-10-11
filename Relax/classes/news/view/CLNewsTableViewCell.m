//
//  CLNewsTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLNewsTableViewCell.h"
#import "CLNewsModel.h"
#import "UIImageView+WebCache.h"
#import "CLCarModel.h"
#import "CLFunneyModel.h"
#import "CLVidioListModel.h"

@interface CLNewsTableViewCell()
@property (nonatomic,strong) NSMutableArray *newsArray; // 存放收藏的新闻的模型
@property (nonatomic,assign) BOOL ISselected;
@end

@implementation CLNewsTableViewCell

- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [NSMutableArray array];
        // 从沙盒中取出已经存在的数组
        // 2.获得文件的全路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newFav.plist"];
        NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (array.count!=0) {
            _newsArray = array; // 如果沙盒中有，就取出
        }
    }
    return _newsArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat magin = 5;
        CGFloat iconW = 100;
        CGFloat iconH=  60;
        CGFloat iconX = magin;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, 2*magin, iconW, iconH)];
        [self.contentView addSubview:self.iconView];
        
        self.stitleLable = [[UILabel alloc] initWithFrame:CGRectMake(iconX+iconW+magin, 0, [UIScreen mainScreen].bounds.size.width-iconW-4*magin, 60)];
        self.stitleLable.numberOfLines = 2;
        [self.contentView addSubview:self.stitleLable];
        
        self.dataLable = [[UILabel alloc] initWithFrame:CGRectMake(iconX+iconW+magin, 50, 100, 20)];
        self.dataLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.dataLable];
        
        self.favriteBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 50, 25, 25)];
        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"funSelected"] forState:UIControlStateNormal];
        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"fun"] forState:UIControlStateSelected];
        [self.favriteBtn addTarget:self action:@selector(clickFav:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.favriteBtn];
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 50, 25, 25)];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"042"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(clickdelBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];

    }
    return self;
}
/**点击删除按钮*/
- (void)clickdelBtn
{
    [self.delegate passModelForDelete:self.Favmodel];
}


// 点击了收藏
- (void)clickFav:(UIButton *)btn
{   //判断用户是否登录
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"];
    NSString *userStr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (userStr) { // 如果已经登录
        self.ISselected = !btn.selected;
//        NSLog(@"%d",self.ISselected);
        if (self.ISselected) {
            self.model.isSelected = YES;
            [self.delegate TableViewReloadData];
            // 从沙盒中取出已经存在的数组
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            // 2.获得文件的全路径
            NSString *path = [doc stringByAppendingPathComponent:@"newFav.plist"];
            NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            self.newsArray = array;
            
            [self.newsArray addObject:self.model];
            [NSKeyedArchiver archiveRootObject:_newsArray toFile:path];   //将对象加入到path路径对应的文件中,archive归档
        } else {
            self.model.isSelected = NO;
            self.favriteBtn.selected = NO;
            [self.delegate clickFavMakeTableViewReloadData:self.model];
//            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newFav.plist"];
//            NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];   //将对象加入到path路径对应的文件中,archive归档
//            [array removeObject:self.model];
//            NSLog(@"%ld---",array.count);
//            [NSKeyedArchiver archiveRootObject:array toFile:path];   //将对象加入到path路径对应的文件中,archive归档
        }
    } else {
        [self.delegate jumpToLoginController];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CLNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setModel:(CLNewsModel *)model
{
    _model = model;
    self.favriteBtn.hidden = NO;
    self.deleteBtn.hidden = YES;
    self.favriteBtn.selected = self.model.isSelected;
    self.dataLable.text = [self.model.sdate substringWithRange:NSMakeRange(5, 5)];
    self.stitleLable.text = self.model.stitle;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.imgsrc] placeholderImage:[UIImage imageNamed:@"1"]];
}

//新闻收藏
- (void)setFavmodel:(CLNewsModel *)Favmodel
{
    _Favmodel = Favmodel;
    self.stitleLable.text = self.Favmodel.stitle;
    self.favriteBtn.hidden = YES;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.Favmodel.imgsrc] placeholderImage:[UIImage imageNamed:@"1"]];
}

- (void)setCarModel:(CLCarModel *)carModel
{
    _carModel = carModel;
    self.stitleLable.text = self.carModel.title;
    self.favriteBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.carModel.picCover] placeholderImage:[UIImage imageNamed:@"1"]];
    NSString *str1 = [self.carModel.lastModify substringWithRange:NSMakeRange(0, 4)];
    NSString *str2 = [self.carModel.lastModify substringWithRange:NSMakeRange(4, 2)];
    NSString *str3 = [self.carModel.lastModify substringWithRange:NSMakeRange(6, 2)];
    self.dataLable.text = [NSString stringWithFormat:@"%@-%@-%@",str1,str2,str3];
}

- (void)setFunModel:(CLFunneyModel *)funModel
{
    _funModel = funModel;
    self.favriteBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    for (CLVidioListModel *model in funModel.videoList) {
        self.dataLable.text = [NSString stringWithFormat:@"时长 %@'",model.duration];
        self.stitleLable.text = model.title;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"1"]];
    }
}


@end
