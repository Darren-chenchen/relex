//
//  TCLFunTableViewCell.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class funFrameModel;


@protocol TCLFunTableViewCellDelegate <NSObject>

@optional
- (void)passModelForShare:(funFrameModel *)funFrameModel andBUtton:(UIButton *)btn;

@end

@interface TCLFunTableViewCell : UITableViewCell

@property (nonatomic,weak) id<TCLFunTableViewCellDelegate> delagate;

@property (nonatomic,strong) funFrameModel *frameModel;

/**发表内容*/
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) UILabel *funLable;
@property (nonatomic,strong) UIButton *shareBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
