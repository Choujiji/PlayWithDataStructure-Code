//
//  LinkStrack.m
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import "LinkStrack.h"
#import "LinkStackElement.h"

@implementation LinkStrack

- (instancetype)init {
    if (self = [super init]) {
        // 创建单链表
        _top = nil;
        _count = 0;
    }
    return self;
}

- (void)push:(NSString *)data {
    // 生成新对象
    LinkStackElement *element = [[LinkStackElement alloc] init];
    element.data = data;
    
    if (!self.top) {
        // 空栈，直接赋值给top指针
        self.top = element;
    } else {
        // 存在数据，新对象的next指向原top对象，top指向新对象
        element.next = self.top;
        self.top = element;
    }
    
    self.count += 1;
}

- (NSString *)pop {
    if (self.count == 0) {
        // 空栈，无数据
        return nil;
    }
    // top指向原top对象的下一个
    LinkStackElement *prevTop = self.top;
    self.top = prevTop.next;
    self.count -= 1;
    return prevTop.data;
}

- (NSString *)description {
    NSString *desc = @"";
    
    LinkStackElement *target = self.top;
    while (target) {
        desc = [NSString stringWithFormat:@"%@\n%@", desc, target];
        // 指针后移
        target = target.next;
    }
    return desc;
}

@end
