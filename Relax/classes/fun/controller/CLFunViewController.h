//
//  CLFunViewController.h
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CLFunTypeOne = 1,
    CLFunTypeTwo = 2,
} CLFunType;

@interface CLFunViewController : UIViewController
/**类型*/
@property (nonatomic,assign) CLFunType type;
@end
