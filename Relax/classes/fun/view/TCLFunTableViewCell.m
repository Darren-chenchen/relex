//
//  TCLFunTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//
#define _ScreenWith [UIScreen mainScreen].bounds.size.width
#define _ScreenHeight [UIScreen mainScreen].bounds.size.height
#define FUNSIZE 15


#define MarginSide 5
#import "TCLFunTableViewCell.h"
#import "funModel.h"
#import "funFrameModel.h"

@implementation TCLFunTableViewCell

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
        self.funLable.font = [UIFont systemFontOfSize:FUNSIZE];
        [self.contentView addSubview:self.funLable];
        self.funLable.textColor = [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1.0];
        
        // 分享按钮
        self.shareBtn = [[UIButton alloc] init];
        self.shareBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 30, 15);
        [self.shareBtn setImage:[UIImage imageNamed:@"shareout"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareBtn];
        [self.shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickShareBtn:(UIButton *)btn
{
    [self.delagate passModelForShare:self.frameModel andBUtton:btn];
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
    //
    self.funLable.text = @"开心一刻";
}

- (void)setingFrame
{
    //内容
    self.contentLable.frame = self.frameModel.contentF;
    //好笑
    self.funLable.frame = self.frameModel.funLableF;
    
    //分享
    self.shareBtn.frame = self.frameModel.shareBtnF;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"funcell";
    
    TCLFunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell = [[TCLFunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
@end
