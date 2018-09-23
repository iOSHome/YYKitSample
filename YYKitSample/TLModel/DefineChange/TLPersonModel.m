//
//  TLPersonModel.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/23.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLPersonModel.h"

@implementation TLEatModel

@end

@implementation TLPersonModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"personId":@"id",
             @"sex":@"sexDic.sex" // 声明sex字段在sexDic下的sex
             };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"eats" : [TLEatModel class]};
}

@end
