//
//  HeroTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeroModel;

@interface HeroTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *htitleLable;

@property (nonatomic,strong) HeroModel *hero;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
