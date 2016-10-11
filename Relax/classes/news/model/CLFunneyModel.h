//
//  CLFunneyModel.h
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLFunneyModel : NSObject

@property (nonatomic,strong) NSArray *itemIdList;
@property (nonatomic,strong) NSArray *videoList;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
