//
//  LinkStackElement.h
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 链栈的元素 */
@interface LinkStackElement : NSObject

/** 数据域 */
@property (strong, nonatomic) NSString *data;

/** 指针域 */
@property (strong, nonatomic) LinkStackElement *next;

@end
