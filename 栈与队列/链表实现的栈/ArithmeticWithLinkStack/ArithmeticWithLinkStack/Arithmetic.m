//
//  Arithmetic.m
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import "Arithmetic.h"
#import "LinkStackElement.h"
#import "LinkStrack.h"

@interface Arithmetic ()

/** 转换为后缀表达式数组 */
- (NSArray *)p_translateToSuffixEquationWithEquation:(NSArray *)equationInfo;

/** 计算后缀表达式结果 */
- (NSInteger)p_calculateWithSuffixEquation:(NSArray *)sufficEquationInfo;

/** 判断是否为数字（NO则为符号） */
- (BOOL)p_isNumber:(NSString *)item;

/** 判断是否为高优先级操作符（*和/） */
- (BOOL)p_isHighPriorityWithOperator:(NSString *)operator;

/** 进行四则运算 */
- (NSInteger)p_calculateSubEquationWithOperator:(NSString *)operator
                                   operation1:(NSString *)operation1
                                   operation2:(NSString *)operation2;

@end

@implementation Arithmetic

- (NSInteger)calculateWithEquation:(NSString *)equation {
    if (!equation.length) {
        return 0;
    }
    
    // 转为数组
    NSArray *equationInfo = [equation componentsSeparatedByString:@" "];
    // 转为后缀表达式数组
    NSArray *suffixInfo = [self p_translateToSuffixEquationWithEquation:equationInfo];
    // 计算后缀表达式结果
    return [self p_calculateWithSuffixEquation:suffixInfo];
}

- (NSArray *)p_translateToSuffixEquationWithEquation:(NSArray *)equationInfo {
    // 依次遍历数组元素，
    // 1. 是数字就插入目标数组；
    // 2. 是符号：左括号 插入；右括号，匹配左括号；其他符号，除 左括号 外的符号依次插入目标数组
    // 3. 清栈
    
    // 创建栈，内部只保存操作符
    LinkStrack *stack = [LinkStrack new];
    // 创建目标数组，用于保存等式结果
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (NSString *item in equationInfo) {
        BOOL isNumber = [self p_isNumber:item];
        // 1. 数字，直接插入目标数组
        if (isNumber) {
            [result addObject:item];
            continue;
        }
        // 2. 当前符号是符号
        
        // 2-1. 是“左括号”，直接入栈
        if ([item isEqualToString:@"("]) {
            [stack push:item];
            continue;
        }
        
        // 2-2. ”右括号“，匹配“左括号”：符号栈依次出栈，直到遇到”左括号“，依次插入目标数组
        if ([item isEqualToString:@")"]) {
            // 获取符号栈的栈顶元素
            NSString *operator = [stack pop];
            while (![operator isEqualToString:@"("]) {
                [result addObject:operator];
                // 符号栈继续出栈，判断
                operator = [stack pop];
            }
            continue;
        }
        
        if (![self p_isHighPriorityWithOperator:item]) {
            // 2-3. 当前符号是低优先级，则符号栈的非“左括号”的符号依次出栈，插入目标数组
            
            // 获取符号栈的栈顶元素
            NSString *operator = stack.top.data;
            while (operator && ![operator isEqualToString:@"("]) {
                // 出栈并加入到目标数组中
                [stack pop];
                [result addObject:operator];
                // 继续查看符号栈栈顶元素
                operator = stack.top.data;
            }
        }
        // 2-4. 当前符号入栈
        [stack push:item];
    }
    
    // 3. 剩余符号依次出栈，并插入目标数组
    while (stack.count > 0) {
        NSString *operator = [stack pop];
        [result addObject:operator];
    }
    
    // 返回目标数组
    NSLog(@"suffix - %@", result);
    return result;
}

- (NSInteger)p_calculateWithSuffixEquation:(NSArray *)sufficEquationInfo {
    // 是数字，就入栈；取到符号时，出栈两个数字，与符号进行运算，结果继续入栈；直到运算结束，取出栈中的结果
    
    // 创建栈，只保存数字
    LinkStrack *stack = [LinkStrack new];
    
    for (NSString *item in sufficEquationInfo) {
        // 1. 数字，直接入栈
        if ([self p_isNumber:item]) {
            [stack push:item];
            continue;
        }
        
        // 2. 符号，数字两次出栈，进行运算，并将结果入栈
        NSString *number1 = [stack pop];
        NSString *number2 = [stack pop];
        
        NSInteger result = [self p_calculateSubEquationWithOperator:item operation1:number2 operation2:number1];
        
        [stack push:[NSString stringWithFormat:@"%ld", result]];
    }
    // 3. 取出栈中结果
    return [[stack pop] integerValue];
}

- (BOOL)p_isNumber:(NSString *)item {
    // 48 ~ 57号 为 0 ~ 9
    unichar ascIndex = [item characterAtIndex:0];
    return (ascIndex >= 48) && (ascIndex <= 57);
}


- (BOOL)p_isHighPriorityWithOperator:(NSString *)operator {
    NSArray *level1 = @[@"*", @"/"];
    return ([level1 indexOfObject:operator] != NSNotFound);
}

- (NSInteger)p_calculateSubEquationWithOperator:(NSString *)operator
                                   operation1:(NSString *)operation1
                                   operation2:(NSString *)operation2 {
    unichar ascIndex = [operator characterAtIndex:0];
    
    NSInteger result = 0;
    
    switch (ascIndex) {
        case 43: // +
            result = operation1.floatValue + operation2.floatValue;
            break;
        case 45: // -
            result = operation1.floatValue - operation2.floatValue;
            break;
        case 42: // *
            result = operation1.floatValue * operation2.floatValue;
            break;
        case 47: // /
            result = operation1.floatValue / operation2.floatValue;
            break;
        default:
            break;
    }
    
    return result;
}

@end
