//
//  CLShareView.h
//  Relax
//
//  Created by darren on 16/5/19.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickFavBlock)();

@interface CLShareView : UIView

@property (nonatomic,strong) NSString *content;

@property (nonatomic,copy) clickFavBlock btnSelected;

@end
