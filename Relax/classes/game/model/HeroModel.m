//
//  HeroModel.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        
        self.img = dict[@"img"];
        self.ids = dict[@"id"];
        
    }
    return self;
}
+ (instancetype)vedioWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.img forKey:@"img"];
}

//从文件中解析对象时会调用，在这个方法中说清楚哪些属性需要存储
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.title = [decoder decodeObjectForKey:@"title"];
        self.img = [decoder decodeObjectForKey:@"img"];

    }
    return self;
}




@end
