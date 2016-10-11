//
//  CLCarModel.m
//  Relax
//
//  Created by Darren on 16/1/11.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLCarModel.h"

@implementation CLCarModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.picCover = dict[@"picCover"];
        self.newsId = dict[@"newsId"];
        self.type = (int)dict[@"type"];
        self.lastModify = dict[@"lastModify"];
    }
    return self;
}

@end
