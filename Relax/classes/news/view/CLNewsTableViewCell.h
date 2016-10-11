//
//  CLNewsTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLNewsModel;
@class CLCarModel;
@class CLFunneyModel;

@protocol CLNewsTableViewCellDelegate <NSObject>
@optional
- (void)clickFavMakeTableViewReloadData:(CLNewsModel *)model;
- (void)jumpToLoginController;
- (void)passModelForDelete:(CLNewsModel *)model;
- (void)TableViewReloadData;
@end

@interface CLNewsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) UILabel *stitleLable;

@property (nonatomic,strong) UILabel *dataLable;

@property (nonatomic,strong) UIButton *favriteBtn;

@property (nonatomic,strong) UIButton *deleteBtn;// 删除按钮

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) CLNewsModel *model;
@property (nonatomic,strong) CLNewsModel *Favmodel;
@property (nonatomic,strong) CLCarModel *carModel;
@property (nonatomic,strong) CLFunneyModel *funModel;

@property (nonatomic,weak) id<CLNewsTableViewCellDelegate> delegate;
@end
