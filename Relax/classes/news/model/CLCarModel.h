//
//  CLCarModel.h
//  Relax
//
//  Created by Darren on 16/1/11.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCarModel : NSObject
@property (nonatomic,copy) NSString *newsId;
@property (nonatomic,copy) NSString *picCover;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *lastModify;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,assign) int type;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
