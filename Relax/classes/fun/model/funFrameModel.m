//
//  funFrameModel.m
//  Relax
//
//  Created by Darren on 15/12/8.
//  Copyright © 2015年 darren. All rights reserved.
//

#import "funFrameModel.h"
#import "funModel.h"

@implementation funFrameModel

/**调用这个方法可以获得文字所在矩形框的尺寸*/
- (CGSize)getRectWith:(NSString *)str and:(int)fontSize andMaxSize:(CGSize)maxSize
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    
    return  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
}

/**重写模型*/
- (void)setFunModel:(funModel *)funModel{
    _funModel = funModel;
    
    _funLableF = CGRectMake(10, 10, 150, 30);
    
    _shareBtnF = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 10, 50, 50);
    
    //内容
    CGFloat magin = 10;
    CGFloat contentX = magin;
    CGFloat contentY = 30 + magin;
    CGSize contentSize = [self getRectWith:self.funModel.content and:17 andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT)];
    _contentF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    _cellHeight = CGRectGetMaxY(_contentF) + magin;
    
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.funModel forKey:@"funmodel"];
}

//从文件中解析对象时会调用，在这个方法中说清楚哪些属性需要存储
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.funModel = [decoder decodeObjectForKey:@"funmodel"];
    }
    return self;
}


@end
