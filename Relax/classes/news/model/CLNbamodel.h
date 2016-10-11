//
//  CLNbamodel.h
//  Relax
//
//  Created by Darren on 16/1/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNbamodel : NSObject
/**详情链接*/
@property (nonatomic,copy) NSString *url;
/**主界面主标题*/
@property (nonatomic,copy) NSString *stitle;
/**跳转界面主标题，只要是视屏，就用这一个标题*/
@property (nonatomic,copy) NSString *title;
/**主界面子标题，没有视频的子标题*/
@property (nonatomic,copy) NSString *wapsummary;
/**=0说明没有视频*/
@property (nonatomic,assign) int video_id;

@property (nonatomic,copy) NSString *img;
/**类型*/
@property (nonatomic,copy) NSString *categoryid;
/**categoryid为parter类型时的图片*/
@property (nonatomic,copy) NSString *image;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
