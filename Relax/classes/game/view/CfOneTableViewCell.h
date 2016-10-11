//
//  CfOneTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/11.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLCfModel;


@interface CfOneTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *mainLable;
@property (nonatomic,strong) UILabel *subLable;
@property (nonatomic,strong) UIButton *favriteBtn;

@property (nonatomic,strong) CLCfModel *cfmodel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
