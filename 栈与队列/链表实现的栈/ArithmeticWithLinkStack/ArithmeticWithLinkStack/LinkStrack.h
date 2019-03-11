//
//  LinkStrack.h
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LinkStackElement;

/** 链栈 */
@interface LinkStrack : NSObject

/** 栈顶指针 */
@property (strong, nonatomic) LinkStackElement *top;

/** 元素个数 */
@property (assign, nonatomic) NSUInteger count;

/** 入栈 */
- (void)push:(NSString *)data;

/** 出栈 */
- (NSString *)pop;

@end
