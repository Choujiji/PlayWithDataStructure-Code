//
//  StaticLinkList.h
//  AlgorithmLearning
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 静态链表 */
@interface StaticLinkList : NSObject

/** 列表长度 */
@property (assign, readonly, nonatomic) NSUInteger length;

/** 初始化链表表 */
- (instancetype)initListWithMaxSize:(NSUInteger)maxSize;

/** 在指定索引位置插入数据 */
- (BOOL)insertData:(NSString *)data atIndex:(NSUInteger)index;

/** 在指定索引位置删除数据 */
- (BOOL)deleteDataAtIndex:(NSUInteger)index;

@end
