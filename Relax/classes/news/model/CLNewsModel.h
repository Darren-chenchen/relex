//
//  CLNewsModel.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNewsModel : NSObject

@property (nonatomic,assign) int comment_num;

@property (nonatomic,copy) NSString *imgsrc;

@property (nonatomic,copy) NSString *imgsrc2;

@property (nonatomic,assign) int joinPeople;

@property (nonatomic,copy) NSString *sdate;

@property (nonatomic,copy) NSString *stitle;

@property (nonatomic,copy) NSString *url;

@property (nonatomic,strong) NSArray *pics;

@property (nonatomic,copy) NSString *type;

@property (nonatomic,assign) BOOL isSelected;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
