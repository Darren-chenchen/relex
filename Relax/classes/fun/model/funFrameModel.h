//
//  funFrameModel.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class funModel;

@interface funFrameModel : NSObject

@property (nonatomic,strong) funModel *funModel;


/**内容的尺寸*/
@property (nonatomic,assign,readonly) CGRect contentF;

@property (nonatomic,assign,readonly) CGRect funLableF;
@property (nonatomic,assign,readonly) CGRect shareBtnF;



/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
