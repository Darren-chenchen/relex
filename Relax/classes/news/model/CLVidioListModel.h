//
//  CLVidioListModel.h
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLVidioListModel : NSObject
@property (nonatomic,strong) NSArray *memberItem;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) int playTime;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,assign) NSNumber *duration;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *guid;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
