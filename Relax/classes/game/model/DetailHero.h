//
//  DetailHero.h
//  Relax
//
//  Created by Darren on 15/12/9.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailHero : NSObject

@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *duration;

@property (nonatomic,copy) NSString *created_at;

@property (nonatomic,copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)vedioWithDict:(NSDictionary *)dict;



@end
