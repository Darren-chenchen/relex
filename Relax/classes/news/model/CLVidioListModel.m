//
//  CLVidioListModel.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLVidioListModel.h"

@implementation CLVidioListModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.image = dict[@"image"];
        self.playTime = (int)dict[@"playTime"];
        self.title = dict[@"title"];
        self.memberItem = dict[@"memberItem"];
        
        if ([dict[@"memberItem"] isKindOfClass:[NSDictionary class]]) {
            self.duration = dict[@"memberItem"][@"duration"];
            self.shareUrl = dict[@"memberItem"][@"shareUrl"];
            self.guid = dict[@"memberItem"][@"guid"];
        }
    }
    return self;
}


@end
