//
//  Element.m
//  AlgorithmLearning
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 jiji. All rights reserved.
//

#import "Element.h"

@implementation Element

- (NSString *)description {
    return [NSString stringWithFormat:@"数据：%@ - 游标：%ld", self.data, self.cur];
}
@end
