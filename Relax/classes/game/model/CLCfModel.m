//
//  CLCfModel.m
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLCfModel.h"

@implementation CLCfModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        
        self.desc = dict[@"desc"];
        self.video_url = dict[@"video_url"];
        self.pic_url = dict[@"pic_url"];
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
    [encoder encodeObject:self.desc forKey:@"desc"];
    [encoder encodeObject:self.video_url forKey:@"video_url"];
    [encoder encodeObject:self.pic_url forKey:@"pic_url"];
    [encoder encodeObject:self.ids forKey:@"ids"];
    
}

//从文件中解析对象时会调用，在这个方法中说清楚哪些属性需要存储
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.title = [decoder decodeObjectForKey:@"title"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
        self.video_url = [decoder decodeObjectForKey:@"video_url"];
        self.pic_url = [decoder decodeObjectForKey:@"pic_url"];
        self.ids = [decoder decodeObjectForKey:@"ids"];        
    }
    return self;
}


@end
