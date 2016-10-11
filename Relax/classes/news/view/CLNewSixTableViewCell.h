//
//  CLNewSixTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLNewsModel;
@class CLCarModel;

@interface CLNewSixTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *mainTitle;

@property (nonatomic,strong) UIImageView *iconView1;
@property (nonatomic,strong) UIImageView *iconView2;

@property (nonatomic,strong) UIImageView *iconView3;

@property (nonatomic,strong)CLNewsModel *model;
@property (nonatomic,strong)CLCarModel *carModel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
