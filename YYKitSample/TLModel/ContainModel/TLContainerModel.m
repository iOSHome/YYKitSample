//
//  TLContainerModel.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLContainerModel.h"

@implementation TLContainerModel

+ (NSDictionary *) modelCustomPropertyMapper {
    return @{@"errnoInteger" : @"errno"
             };
}

@end


@implementation Data

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [List class]};
}

@end


@implementation Latest_Expire_Bonus

@end


@implementation List

@end
