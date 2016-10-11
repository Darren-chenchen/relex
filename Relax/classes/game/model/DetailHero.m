//
//  DetailHero.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "DetailHero.h"

@implementation DetailHero
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.created_at = dict[@"created_at"];
        self.url = dict[@"url"];
        
        self.img = dict[@"img"];
        self.title = dict[@"title"];
        self.duration = dict[@"duration"];
        
    }
    return self;
}
+ (instancetype)vedioWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
