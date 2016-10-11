//
//  Request.h
//  上课-糗百
//
//  Created by Darren on 15/12/4.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol RequestDelegate <NSObject>

@optional
- (void)passData:(id)data;

@end

@interface Request : NSObject

@property (nonatomic,copy) NSString *type;

- (void)requestDataFromUrlString:(NSString *)urlString;

@property (nonatomic,weak) id<RequestDelegate>delegate;

@end
