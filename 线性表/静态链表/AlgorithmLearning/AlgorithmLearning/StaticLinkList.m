//
//  StaticLinkList.m
//  AlgorithmLearning
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import "StaticLinkList.h"
#import "Element.h"

@interface StaticLinkList ()

/** 链表最大容量 */
@property (assign, nonatomic) NSUInteger maxSize;

/** 真正用于存储数据的容器 */
@property (strong, nonatomic) NSArray<Element *> *dataArray;

/** 获取可用空间索引 */
- (NSUInteger)p_getAvailableIndex;

/** 释放指定位置的元素 */
- (void)p_releaseElemAtIndex:(NSUInteger)index;

@end

@implementation StaticLinkList

- (instancetype)initListWithMaxSize:(NSUInteger)maxSize {
    if (self = [super init]) {
        _maxSize = maxSize;
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:_maxSize];
        
        for (NSUInteger i = 0; i <= _maxSize - 1; i += 1) {
            Element *elem = [Element new];
            // 游标存储的是下一个元素的数组索引
            elem.cur = i + 1;
            [dataArray addObject:elem];
        }
        // 最后一个数据的游标为首个数据索引（空链表）
        Element *theLastElem = [Element new];
        theLastElem.cur = 0;
        [dataArray addObject:theLastElem];
        
        _dataArray = [dataArray copy];
    }
    return self;
}

- (NSUInteger)p_getAvailableIndex {
    // 由于首个元素的游标指向第一个可用数据，故直接返回
    NSUInteger availableIndex = [self.dataArray firstObject].cur;
    
    // 返回后，将下一个元素的索引（即当前元素的游标）赋值给头元素的游标，以备下次使用
    [self.dataArray firstObject].cur = self.dataArray[availableIndex].cur;
    
    return availableIndex;
}

- (void)p_releaseElemAtIndex:(NSUInteger)index {
    Element *elem = self.dataArray[index];
    NSUInteger firstAvailableIndex = [self.dataArray firstObject].cur;
    
    // 当前元素的游标指向第一个空数据的位置（头元素的游标）
    elem.cur = firstAvailableIndex;
    // 清除数据
    elem.data = nil;
    
    // 头元素的游标指向当前索引
    [self.dataArray firstObject].cur = index;
}

- (NSUInteger)length {
    // 从“头”（最后一个元素）访问，找到第一个元素的游标为0，返回计数
    NSUInteger count = 0;
    
    NSUInteger head = self.maxSize - 1;
    
    Element *elem = self.dataArray[head];
    while (elem.cur) {
        // 游标后移，指向下一个元素
        head = elem.cur;
        elem = self.dataArray[head];
        count += 1;
    }
    
    // 当前head指向的元素的游标为0，即到达链表的末尾
    return count;
}

- (BOOL)insertData:(NSString *)data atIndex:(NSUInteger)index {
    // 由于链表的第一项作为空数据索引的起点，故数据最小插入索引为1；
    // 且数据不能跳过空位插入，故索引最大只能比length大1
    if (index < 1 || index > self.length + 1) {
        return NO;
    }
    
    // 获取可用空间索引
    NSUInteger availableIndex = [self p_getAvailableIndex];
    if (availableIndex == 0) {
        return NO;
    }
    
    // 取出当前元素，赋值
    Element *newElem = self.dataArray[availableIndex];
    newElem.data = data;
    
    // 从“头”访问，找到插入位置的前一个元素
    NSUInteger head = self.maxSize - 1;
    for (NSUInteger i = 0; i <= index - 1; i += 1) {
        // 游标后移，查找下一个元素的位置
        NSUInteger targetIndex = self.dataArray[head].cur;
        head = targetIndex;
    }
    // 此时head为前一个元素在数组中的索引
    // 获取前一个元素
    Element *prevElem = self.dataArray[head];
    
    // 让新元素的游标指向插入位置原始元素的索引（即前一个元素的游标）
    newElem.cur = prevElem.cur;
    
    // 让插入位置的前一个元素的游标指向新元素的索引
    prevElem.cur = availableIndex;
    
    return YES;
}

- (BOOL)deleteDataAtIndex:(NSUInteger)index {
    // 只能删除范围内的数据
    if (index < 1 || index > self.length) {
        return NO;
    }
    
    // 从“头”开始访问，找到删除位置的前一个数据
    NSUInteger head = self.maxSize - 1;
    for (NSUInteger i = 0; i <= index - 1; i += 1) {
        // 游标后移
        Element *targetElem = self.dataArray[head];
        head = targetElem.cur;
    }
    // 此时head为前一个元素在数组中的索引
    // 获取前一个元素
    Element *prevElem = self.dataArray[head];
    
    // 待删除元素在数组中的索引
    NSUInteger deleteIndex = prevElem.cur;
    
    // 下一个元素在数组中的索引
    NSUInteger nextIndex = self.dataArray[deleteIndex].cur;
    
    // 前一个元素的游标指向待删除元素的游标（下一个元素的位置）
    prevElem.cur = nextIndex;
    
    // 释放删除元素
    [self p_releaseElemAtIndex:deleteIndex];
    
    return YES;
}

- (NSString *)description {
    NSString *desc = @"";
    
    // 从“头”开始访问，依次打印有效元素
    NSUInteger head = self.maxSize - 1;
    Element *elem = self.dataArray[head];
    while (elem.cur) {
        if (elem.data) {
            // 只打印有数据的元素
            desc = [NSString stringWithFormat:@"%@\n%@", desc, elem.description];
        }
        // 游标后移
        head = elem.cur;
        // 获取下一个元素
        elem = self.dataArray[head];
    }
    // 最后一个数据也要打印
    desc = [NSString stringWithFormat:@"%@\n%@", desc, elem.description];

    return desc;
}

@end
