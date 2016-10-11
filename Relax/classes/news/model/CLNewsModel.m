//
//  CLNewsModel.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "CLNewsModel.h"

@implementation CLNewsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.comment_num = (int)dict[@"comment_num"];
        self.imgsrc = dict[@"imgsrc"];
        self.imgsrc2 = dict[@"imgsrc2"];
        self.joinPeople = (int)dict[@"joinPeople"];
        
        self.sdate = dict[@"sdate"];
        self.stitle = dict[@"stitle"];
        
        self.url = dict[@"url"];
        self.type = dict[@"type"];
        self.pics = dict[@"pics"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.imgsrc forKey:@"imgsrc"];
    [encoder encodeObject:self.stitle forKey:@"stitle"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.pics forKey:@"pics"];
    [encoder encodeObject:self.sdate forKey:@"sdate"];
    [encoder encodeObject:self.type forKey:@"type"];

}

//从文件中解析对象时会调用，在这个方法中说清楚哪些属性需要存储
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.imgsrc = [decoder decodeObjectForKey:@"imgsrc"];
        self.stitle = [decoder decodeObjectForKey:@"stitle"];
        self.url = [decoder decodeObjectForKey:@"url"];
        self.pics = [decoder decodeObjectForKey:@"pics"];
        self.sdate = [decoder decodeObjectForKey:@"sdate"];
        self.sdate = [decoder decodeObjectForKey:@"type"];

    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
}

@end
