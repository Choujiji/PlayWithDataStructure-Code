//
//  Arithmetic.h
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 四则运算 */
@interface Arithmetic : NSObject

/** 计算算式结果 */
- (NSInteger)calculateWithEquation:(NSString *)equation;

@end
