//
//  funModel.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface funModel : NSObject

/**内容*/
@property (nonatomic,copy) NSString *content;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
