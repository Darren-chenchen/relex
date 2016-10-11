//
//  CLNBATableViewCell.m
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLNBATableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CLNbamodel.h"
#import "UIView+MJExtension.h"
#import "CLCarModel.h"

@implementation CLNBATableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat magin = 5;
        CGFloat iconW = 100;
        CGFloat iconH=  70;
        CGFloat iconX = magin;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, 3*magin, iconW, iconH)];
        [self.contentView addSubview:self.iconView];
        
        self.stitleLable = [[UILabel alloc] initWithFrame:CGRectMake(iconX+iconW+magin, 0, [UIScreen mainScreen].bounds.size.width-iconW-4*magin, 60)];
        self.stitleLable.numberOfLines = 2;
        [self.contentView addSubview:self.stitleLable];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(iconX+iconW+magin, 50, [UIScreen mainScreen].bounds.size.width-iconW-4*magin, 40)];
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textColor = [UIColor grayColor];
        self.title.numberOfLines = 0;
        [self.contentView addSubview:self.title];
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CLNBATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CLNBATableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}

- (void)setModel:(CLNbamodel *)model
{
    _model = model;
    self.title.text = self.model.title;
    self.stitleLable.text = self.model.stitle;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.img] placeholderImage:[UIImage imageNamed:@"1"]];
    if ([self.model.categoryid isEqualToString:@"partner"]) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@"1"]];
    }
}

@end
