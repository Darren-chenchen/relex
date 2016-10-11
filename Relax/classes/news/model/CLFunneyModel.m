//
//  CLFunneyModel.m
//  Relax
//
//  Created by Darren on 16/1/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLFunneyModel.h"
#import "CLVidioListModel.h"

@implementation CLFunneyModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.itemIdList = dict[@"itemIdList"];
        self.videoList = dict[@"videoList"];
        
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSDictionary *dict in self.videoList) {
            CLVidioListModel *vidioModel = [[CLVidioListModel alloc] initWithDict:dict];
            [mutArr addObject:vidioModel];
        }
        _videoList = mutArr;
    }
    return self;
}

@end
