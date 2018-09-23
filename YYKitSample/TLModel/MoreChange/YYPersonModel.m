//
//  YYPersonModel.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/23.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "YYPersonModel.h"

@implementation YYPersonModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"personId":@"id",
             @"sex":@"sexDic.sex" // 声明sex字段在sexDic下的sex
             };
}

@end
