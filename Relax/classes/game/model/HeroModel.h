//
//  HeroModel.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *img;

@property (nonatomic,copy) NSString *ids;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)vedioWithDict:(NSDictionary *)dict;

@end
