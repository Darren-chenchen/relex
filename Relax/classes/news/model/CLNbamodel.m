//
//  CLNbamodel.m
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLNbamodel.h"

@implementation CLNbamodel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.stitle = dict[@"stitle"];
        self.title = dict[@"title"];
        self.categoryid = dict[@"categoryid"];
        self.image = dict[@"image"];
        self.url = dict[@"url"];
        if ([dict[@"img"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *imgDic = dict[@"img"];
            self.img = imgDic[@"u"];
        }
    }
    return self;
}

@end
