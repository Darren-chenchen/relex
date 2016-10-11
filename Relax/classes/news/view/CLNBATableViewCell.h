//
//  CLNBATableViewCell.h
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLNbamodel;

@interface CLNBATableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) UILabel *stitleLable;

@property (nonatomic,strong) UILabel *title;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CLNbamodel *model;


@end
