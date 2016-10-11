//
//  CLNewSixTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLNewSixTableViewCell.h"
#import "CLNewsModel.h"
#import "UIImageView+WebCache.h"
#import "CLCarModel.h"

@implementation CLNewSixTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width, 30)];
        [self.contentView addSubview:self.mainTitle];
        
        CGFloat iconW = ([UIScreen mainScreen].bounds.size.width-20)/3;
        self.iconView1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, iconW, 70)];
        [self.contentView addSubview:self.iconView1];
        
        self.iconView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10+iconW, 40, iconW, 70)];
        [self.contentView addSubview:self.iconView2];
        
        self.iconView3 = [[UIImageView alloc] initWithFrame:CGRectMake(15+2*iconW, 40, iconW, 70)];
        [self.contentView addSubview:self.iconView3];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *SIXID = @"Sixcell";
    CLNewSixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SIXID];
    if (cell == nil) {
        cell = [[CLNewSixTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SIXID];
    }
    return cell;
    
}

- (void)setModel:(CLNewsModel *)model
{
    _model = model;
    self.mainTitle.text = self.model.stitle;
    [self.iconView1 sd_setImageWithURL:[NSURL URLWithString:self.model.pics[0]]];
    [self.iconView2 sd_setImageWithURL:[NSURL URLWithString:self.model.pics[1]]];
    [self.iconView3 sd_setImageWithURL:[NSURL URLWithString:self.model.pics[2]]];
}
- (void)setCarModel:(CLCarModel *)carModel
{
    _carModel = carModel;
    self.mainTitle.text = self.carModel.title;
    NSArray *array = [self.carModel.picCover componentsSeparatedByString:@";"];
    [self.iconView1 sd_setImageWithURL:[NSURL URLWithString:array[0]]];
    [self.iconView2 sd_setImageWithURL:[NSURL URLWithString:array[1]]];
    [self.iconView3 sd_setImageWithURL:[NSURL URLWithString:array[2]]];
}


@end
