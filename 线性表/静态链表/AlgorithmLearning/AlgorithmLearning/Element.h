//
//  Element.h
//  AlgorithmLearning
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 元素 */
@interface Element : NSObject

/** 数据域 */
@property (strong, nonatomic) NSString *data;

/** 游标（指向下一个元素的位置） */
@property (assign, nonatomic) NSUInteger cur;

@end
