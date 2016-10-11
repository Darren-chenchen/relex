//
//  DetailTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailHero.h"

@implementation DetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat magin = 5;
        CGFloat iconX = magin;
        CGFloat iconY = magin;
        CGFloat iconW = 60;
        CGFloat iconH = 60;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        [self.contentView addSubview:self.iconView];
        
        self.htitleLable = [[UILabel alloc] initWithFrame:CGRectMake(iconX*2*magin+20, iconY, [UIScreen mainScreen].bounds.size.width - 100, 40)];
        self.htitleLable.font = [UIFont systemFontOfSize:14];
        self.htitleLable.numberOfLines = 0;
        [self.contentView addSubview:self.htitleLable];
        
        self.timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(iconX*2*magin, 40, 80, 25)];
        [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.timeBtn];
        
        self.pubdateBtn = [[UIButton alloc] initWithFrame:CGRectMake(iconX*2*magin+120, 40, 100, 25)];
        [self.pubdateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.pubdateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.pubdateBtn];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setDetalhero:(DetailHero *)detalhero
{
    _detalhero = detalhero;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:detalhero.img] placeholderImage:[UIImage imageNamed:@"111"]];
    self.htitleLable.text = detalhero.title;
    [self.timeBtn setTitle:detalhero.duration forState:UIControlStateNormal];
    
    [self.pubdateBtn setTitle:[detalhero.created_at substringWithRange:NSMakeRange(0, 10)] forState:UIControlStateNormal];
}
@end
