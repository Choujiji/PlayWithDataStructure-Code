//
//  main.m
//  KMPStringCompare
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 获取next数组 */
NSArray *getNextInfo(const char *targetStr) {
    // 创建返回的next数组
    NSMutableArray *nextInfo = [[NSMutableArray alloc] initWithCapacity:10];
    nextInfo[0] = @(-1); // 人为指定首位的next值为-1（首位无法回溯，故此值只是占位用）
    
    // 获取字符串长度
    NSInteger strLength = strlen(targetStr);
    
    NSInteger tailIndex = 0; // 后缀索引初始值
    NSInteger headIndex = -1; // 前缀索引初始值
    
    // 以后缀索引进行遍历（字符串匹配，本身为主串，headIndex为目标串）
    while (tailIndex < strLength - 1) {
        if ((headIndex == -1)
            || (targetStr[tailIndex] == targetStr[headIndex])) {
            tailIndex += 1;
            headIndex += 1;
            nextInfo[tailIndex] = @(headIndex);
        } else {
            // 当前字符不相同，触发索引回溯
            // 后缀索引不变，前缀索引回溯，找到next数组当前索引对应的位置，以便下一次匹配
            headIndex = [nextInfo[headIndex] integerValue];
        }
        
//        NSLog(@"tailIndex = %ld", tailIndex);
//        NSLog(@"headIndex - %ld", headIndex);
//        NSLog(@"next ---- %ld", [nextInfo[tailIndex] integerValue]);
    }

    return [nextInfo copy];
}

/** 使用KMP方式查找子串在主串中的索引 */
NSInteger KMPFindIndex(const char *sourceStr, const char *targetStr) {
    // 获取目标串的next信息，以备匹配时进行回溯（KMP算法核心）
    NSArray *nextInfo = getNextInfo(targetStr);
    NSLog(@"next - %@", nextInfo);
    
    // 主串索引
    NSInteger sourceIndex = 0;
    // 目标串索引
    NSInteger targetIndex = 0;
    
    // 获取两串长度
    NSInteger sourceLength = strlen(sourceStr);
    NSInteger targetLength = strlen(targetStr);
    
    // 均在范围内查找
    while ((sourceIndex < sourceLength)
           && (targetIndex < targetLength)) {
        if ((targetIndex == -1)
            || (sourceStr[sourceIndex] == targetStr[targetIndex])) {
            // targetIndex = -1，即匹配next[0] = -1的情况
            
            // 字符相同时
            
            // 索引均后移，继续匹配
            sourceIndex += 1;
            targetIndex += 1;
        } else {
            // 字符不相同
            // 目标串索引回溯，回溯到当前的next指向的位置，作为下一次匹配的起点
            targetIndex = [nextInfo[targetIndex] integerValue];
        }
    }
    
    if (targetIndex == targetLength) {
        // 目标串索引在自身最后了（即自身每一个字符均已经匹配成功），匹配成功
        return sourceIndex - targetIndex;
    }
    
    // 未找到
    return NSNotFound;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        const char *str = "ABCDABDE";
//        NSArray *nextInfo = getNextInfo(str);
//        NSLog(@"%@", nextInfo);


        // 字符串查找
        const char *source = "ababababca";
        const char *target = "abababca";
        NSInteger index = KMPFindIndex(source, target);
        NSLog(@"position = %ld", index);
    }
    return 0;
}
