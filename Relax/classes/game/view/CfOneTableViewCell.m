//
//  CfOneTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/11.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CfOneTableViewCell.h"
#import "CLCfModel.h"

@implementation CfOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat magin = 10;
        CGFloat mainLableX = magin;
        CGFloat mainLableW = [UIScreen mainScreen].bounds.size.width-4*mainLableX;
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
        
//        self.favriteBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-40, magin, 20, 20)];
//        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"funSelected"] forState:UIControlStateNormal];
//        [self.favriteBtn setBackgroundImage:[UIImage imageNamed:@"fun"] forState:UIControlStateSelected];
//        [self.favriteBtn addTarget:self action:@selector(clickFav:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.favriteBtn];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *CFID = @"cfcell";
    CfOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CFID];
    if (!cell) {
        cell = [[CfOneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CFID];
    }
    
    return cell;

}

- (void)setCfmodel:(CLCfModel *)cfmodel
{
    _cfmodel = cfmodel;
    self.mainLable.text = cfmodel.title;
    self.subLable.text = cfmodel.desc;

}
@end
