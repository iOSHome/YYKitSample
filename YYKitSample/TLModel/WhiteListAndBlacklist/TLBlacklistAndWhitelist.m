//
//  TLBlacklistAndWhitelist.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLBlacklistAndWhitelist.h"

@implementation TLBlacklistAndWhitelist

//+ (NSArray *)modelPropertyWhitelist {
//    return @[@"name"];
//}

+ (NSArray *)modelPropertyBlacklist {
    return @[@"uid"];
}

@end
