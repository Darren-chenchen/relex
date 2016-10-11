//
//  Request.m
//  上课-糗百
//
//  Created by Darren on 15/12/4.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "Request.h"
#import <AFNetworking.h>

@implementation Request

- (void)requestDataFromUrlString:(NSString *)urlString
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:self.type, nil];

    
    [manger GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
        [self.delegate passData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

@end
