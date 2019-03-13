//
//  main.m
//  SimplyStringCompare
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 查看子串索引 */
NSInteger findSubStringIndex(NSString *sourceString, NSString *targetString) {
    if ((!targetString.length)
        || (targetString.length > sourceString.length)) {
        return NSNotFound;
    }
    // 从source的开头开始遍历，直到sourceString - targetString长度为止
    NSInteger endIndex = sourceString.length - targetString.length;
    for (NSInteger i = 0; i <= endIndex; i += 1) {
        // 依次比较每个位置字符，不一样则进入下一循环
        BOOL isSame = YES;
        NSInteger sourceStartIndex = i;
        for (NSInteger j = 0; j < targetString.length; j += 1) {
            NSString *subSource = [sourceString substringWithRange:NSMakeRange(sourceStartIndex, 1)];
            NSString *subTarget = [targetString substringWithRange:NSMakeRange(j, 1)];
            if (![subTarget isEqualToString:subSource]) {
                isSame = NO;
                break;
            }
            sourceStartIndex += 1;
        }
        if (isSame) {
            // 相同，直接返回当前source的索引
            return i;
        }
    }
    return NSNotFound;
}

NSInteger findSubStrIndex(char *sourceStr, char *targetStr) {
    // 1. 获取两字符串长度
    
    /** 源串长度 （运算次数：m次）*/
    NSInteger sourceLength = 0;
    while (sourceStr[sourceLength]) {
        sourceLength += 1;
    }
    /** 目标串长度 （运算次数：n次）*/
    NSInteger targetLength = 0;
    while (targetStr[targetLength]) {
        targetLength += 1;
    }
    
    // 2. 依次比较字符（总运算次数： a + b）
    
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    while ((sourceIndex < sourceLength)
           && (targetIndex < targetLength)) {
        // 比较指定位置字符是否相同
        char source = sourceStr[sourceIndex];
        char target = targetStr[targetIndex];
        if (source == target) {
            // 相同，同时后移索引
            sourceIndex += 1;
            targetIndex += 1;
        } else {
            // 不相同
            // 源串索引变为初始比较时的下一位（运算a次）
            sourceIndex = sourceIndex - targetIndex + 1;
            // 目标串索引重置（运算b次）
            targetIndex = 0;
        }
    }
    
    // 目标串遍历索引超过目标串长度时，认为每个字符都已匹配成功 （运算次数：1）
    if (targetIndex >= targetLength) {
        // 源串的最终遍历索引 前移 目标串长度，即为子串的起始位置
        return sourceIndex - targetLength;
    }
    
    // 最终总运算次数为 (m + n) + (a + b) + 1
    return NSNotFound;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 自己瞎实现的，复杂度为O(n^2)
        NSString *source = @"goodgoogle";
        NSString *target = @"google";
        
        NSInteger index = findSubStringIndex(source, target);
        
        NSLog(@"startIndex = %ld", index);
        
        
        // 朴素的模式匹配算法，复杂度为O(n)
        char *sourceStr = "goodgoogle";
        char *targetStr = "google";
        NSInteger position = findSubStrIndex(sourceStr, targetStr);
        NSLog(@"startPosition = %ld", position);
    }
    return 0;
}
