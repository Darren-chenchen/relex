//
//  CLFavoriteTableViewCell.h
//  Relax
//
//  Created by Darren on 16/1/13.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class funFrameModel;

@protocol CLFavoriteTableViewCellDelegate <NSObject>

@optional
- (void)passModelForShare:(funFrameModel *)funFrameModel;
- (void)passModelForDelete:(funFrameModel *)frameModel;

@end
@interface CLFavoriteTableViewCell : UITableViewCell

@property (nonatomic,weak) id<CLFavoriteTableViewCellDelegate> delagate;

@property (nonatomic,strong) funFrameModel *frameModel;

/**发表内容*/
@property (nonatomic,strong) UILabel *contentLable;
/**收藏时间*/
@property (nonatomic,strong) UILabel *FavoriteTimeLable;

@property (nonatomic,strong) UILabel *funLable;
/**分享按钮*/
@property (nonatomic,strong) UIButton *shareBtn;
/**删除按钮*/
@property (nonatomic,strong) UIButton *delBtn;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
