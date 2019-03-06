//
//  main.m
//  AlgorithmLearning
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticLinkList.h"

/** 静态链表最大长度 */
static NSUInteger const kListMaxSize = 1000;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 初始化链表
        StaticLinkList *list = [[StaticLinkList alloc] initListWithMaxSize:kListMaxSize];
        
        // 插入数据
        [list insertData:@"甲" atIndex:1];
        [list insertData:@"乙" atIndex:2];
        [list insertData:@"丁" atIndex:3];
        [list insertData:@"戊" atIndex:4];
        [list insertData:@"己" atIndex:5];
        [list insertData:@"庚" atIndex:6];
        [list insertData:@"丙" atIndex:3];

        NSLog(@"%@", list);
        
        // 删除数据
        [list deleteDataAtIndex:3];
        
        NSLog(@"%@", list);
    }
    return 0;
}

