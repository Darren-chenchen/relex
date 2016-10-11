//
//  funModel.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "funModel.h"

@implementation funModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.content = dict[@"content"];
    }
    
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.content forKey:@"content"];
}

//从文件中解析对象时会调用，在这个方法中说清楚哪些属性需要存储
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.content = [decoder decodeObjectForKey:@"content"];
    }
    return self;
}

@end
