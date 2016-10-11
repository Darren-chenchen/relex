//
//  HeroTableViewCell.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "HeroTableViewCell.h"
#import "HeroModel.h"
#import "UIImageView+WebCache.h"

@implementation HeroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat magin = 5;
        CGFloat iconX = magin;
        CGFloat iconY = magin;
        CGFloat iconW = 50;
        CGFloat iconH = 50;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        [self.contentView addSubview:self.iconView];
        
        self.htitleLable = [[UILabel alloc] initWithFrame:CGRectMake(iconX*2*magin+15, iconY+10, [UIScreen mainScreen].bounds.size.width - 110, 35)];
        [self.contentView addSubview:self.htitleLable];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *HeroID = @"cell";
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeroID];
    
    if (cell == nil) {
        cell = [[HeroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeroID];
    }
    return cell;
}

- (void)setHero:(HeroModel *)hero
{
    _hero = hero;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:hero.img] placeholderImage:[UIImage imageNamed:@"111.jpg"]];
    self.htitleLable.text = hero.title;
}

@end
