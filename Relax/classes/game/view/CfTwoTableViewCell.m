//
//  CfTwoTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/11.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CfTwoTableViewCell.h"
#import "CLCfModel.h"
#import "UIImageView+WebCache.h"

@interface CfTwoTableViewCell()
@property (nonatomic,strong) NSMutableArray *newsArray; // 存放收藏的新闻的模型
@property (nonatomic,assign) BOOL ISselected;
@end

@implementation CfTwoTableViewCell

- (NSMutableArray *)newsArray
{
    if (_newsArray == nil) {
        _newsArray = [NSMutableArray array];
        // 从沙盒中取出已经存在的数组
        // 2.获得文件的全路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gameFav.plist"];
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
        
        CGFloat magin = 10;
        CGFloat iconViewX = magin;
        CGFloat iconViewW = 120;
        CGFloat iconViewH = 80;
        CGFloat iconViewY = magin;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH)];
        [self.contentView addSubview:self.iconView];
        
        CGFloat mainLableX = iconViewW+iconViewX+magin;
        CGFloat mainLableW = [UIScreen mainScreen].bounds.size.width-mainLableX-magin;
        CGFloat mainLableH = 30;
        CGFloat mainLableY = magin;
        self.mainLable = [[UILabel alloc] initWithFrame:CGRectMake(mainLableX, mainLableY, mainLableW, mainLableH)];
        self.mainLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.mainLable];
        
        self.subLable = [[UILabel alloc] initWithFrame:CGRectMake(mainLableX, mainLableY+mainLableH, mainLableW, 25)];
        self.subLable.font = [UIFont systemFontOfSize:14];
        self.subLable.textColor = [UIColor grayColor];
        self.subLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.subLable];
        
        self.favriteBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 70, 25, 25)];
        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"funSelected"] forState:UIControlStateNormal];
        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"fun"] forState:UIControlStateSelected];
        [self.favriteBtn addTarget:self action:@selector(clickFav:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.favriteBtn];
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, 70, 25, 25)];
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
        if (self.ISselected) {
            self.cfmodel.isSelected = YES;
            [self.delegate TableViewReloadData];
            // 从沙盒中取出已经存在的数组
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            // 2.获得文件的全路径
            NSString *path = [doc stringByAppendingPathComponent:@"gameFav.plist"];
            NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            self.newsArray = array;
            
            [self.newsArray addObject:self.cfmodel];
            [NSKeyedArchiver archiveRootObject:_newsArray toFile:path];   //将对象加入到path路径对应的文件中,archive归档
        } else {
            self.cfmodel.isSelected = NO;
            self.favriteBtn.selected = NO;
            [self.delegate clickFavMakeTableViewReloadData:self.cfmodel];
        }
    } else {
        [self.delegate jumpToLoginController];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CFID2 = @"cfcell2";
    CfTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CFID2];
    if (!cell) {
        cell = [[CfTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CFID2];
    }
    
    return cell;
    
}

- (void)setCfmodel:(CLCfModel *)cfmodel
{
    _cfmodel = cfmodel;
    self.favriteBtn.hidden = NO;
    self.deleteBtn.hidden = YES;
    self.favriteBtn.selected = self.cfmodel.isSelected;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cfmodel.pic_url] placeholderImage:[UIImage imageNamed:@"game2"]];
    self.mainLable.text = cfmodel.title;
    self.subLable.text = cfmodel.desc;
    
}

- (void)setFavmodel:(CLCfModel *)Favmodel
{
    _Favmodel = Favmodel;
    self.favriteBtn.hidden = YES;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.Favmodel.pic_url] placeholderImage:[UIImage imageNamed:@"game2"]];
    self.mainLable.text = self.Favmodel.title;
    self.subLable.text = self.Favmodel.desc;
}



@end
