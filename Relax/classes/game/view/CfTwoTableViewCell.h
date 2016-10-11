//
//  CfTwoTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/11.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLCfModel;
@protocol CfTwoTableViewCellDelegate <NSObject>
@optional
- (void)clickFavMakeTableViewReloadData:(CLCfModel *)model;
- (void)jumpToLoginController;
- (void)passModelForDelete:(CLCfModel *)model;
- (void)TableViewReloadData;
@end


@interface CfTwoTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *mainLable;
@property (nonatomic,strong) UILabel *subLable;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UIButton *favriteBtn;
@property (nonatomic,strong) UIButton *deleteBtn;// 删除按钮
@property (nonatomic,strong) CLCfModel *Favmodel;

@property (nonatomic,strong) CLCfModel *cfmodel;
@property (nonatomic,weak) id<CfTwoTableViewCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
