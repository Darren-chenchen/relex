//
//  DetailTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailHero;

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *htitleLable;

@property (nonatomic,strong) UIButton *timeBtn;

@property (nonatomic,strong) UIButton *pubdateBtn;


@property (nonatomic,strong) DetailHero *detalhero;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
