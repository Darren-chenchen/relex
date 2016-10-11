//
//  CLFavoriteTableViewCell.m
//  Relax
//
//  Created by Darren on 16/1/13.
//  Copyright © 2016年 darren. All rights reserved.
//
#define _ScreenWith [UIScreen mainScreen].bounds.size.width
#define _ScreenHeight [UIScreen mainScreen].bounds.size.height
#define FUNSIZE 15


#define MarginSide 5
#import "CLFavoriteTableViewCell.h"
#import "funModel.h"
#import "funFrameModel.h"

@implementation CLFavoriteTableViewCell

// 添加所有子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /**用户发表的内容*/
        self.contentLable = [[UILabel alloc] init];
        self.contentLable.numberOfLines = 0;
        [self.contentView addSubview:self.contentLable];
        
        /**开心一刻*/
        self.funLable = [[UILabel alloc] init];
        self.funLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.funLable];
        self.funLable.textColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1.0];
        
        /**收藏时间*/
        self.FavoriteTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(_ScreenWith*0.5-100, 10, 200, 30)];
        self.FavoriteTimeLable.font = [UIFont systemFontOfSize:FUNSIZE];
        [self.contentView addSubview:self.FavoriteTimeLable];
        self.FavoriteTimeLable.textAlignment = NSTextAlignmentCenter;
        self.FavoriteTimeLable.textColor = [UIColor colorWithRed:200/255. green:150/255. blue:80/255. alpha:1];

        
        // 删除按钮
        self.delBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 10, 20, 20)];
        [self.delBtn setBackgroundImage:[UIImage imageNamed:@"042"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.delBtn];
        [self.delBtn addTarget:self action:@selector(clickdelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        // 分享按钮
        self.shareBtn = [[UIButton alloc] init];
        self.shareBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
        [self.shareBtn setImage:[UIImage imageNamed:@"shareout"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareBtn];
        [self.shareBtn addTarget:self action:@selector(clickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickShareBtn
{
    [self.delagate passModelForShare:self.frameModel];
}

/**点击删除按钮*/
- (void)clickdelBtn
{
    [self.delagate passModelForDelete:self.frameModel];
}

/**重写funFrameMOdel模型*/
- (void)setFrameModel:(funFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    [self setingDate];
    
    [self setingFrame];
}

- (void)setingDate
{
    //内容
    self.contentLable.text = self.frameModel.funModel.content;
}


- (void)setingFrame
{
    //内容
    self.contentLable.frame = self.frameModel.contentF;
    //
    self.funLable.frame = self.frameModel.funLableF;
    //分享
    self.shareBtn.frame = self.frameModel.shareBtnF;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *IDF = @"favcell";
    
    CLFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDF];
    
    if (cell==nil) {
        cell = [[CLFavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDF];
    }
    return cell;
}
@end
