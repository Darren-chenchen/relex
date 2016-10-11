//
//  CLCfModel.h
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCfModel : NSObject
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *pic_url;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *ids;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,copy) NSString *video_url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)vedioWithDict:(NSDictionary *)dict;


@end
