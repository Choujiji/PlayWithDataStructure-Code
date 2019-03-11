//
//  main.m
//  ArithmeticWithLinkStack
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LinkStrack.h"
#import "Arithmetic.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        LinkStrack *stack = [LinkStrack new];
//
//        [stack push:@"1"];
//        [stack push:@"2"];
//        [stack push:@"3"];
//
//        NSLog(@"%@", stack);
//
//        [stack pop];
//
//        NSLog(@"%ld", stack.count);
//        NSLog(@"%@", stack);
//
//        NSLog(@"%d", [@"2" characterAtIndex:0]);
        
        
        // 四则运行计算
        
        NSString *equation = @"9 + ( 3 - 1 ) * 3 + 10 / 2";
        
        Arithmetic *arithmetic = [Arithmetic new];
        NSInteger result = [arithmetic calculateWithEquation:equation];
        NSLog(@"result = %ld", result);
    }
    return 0;
}
