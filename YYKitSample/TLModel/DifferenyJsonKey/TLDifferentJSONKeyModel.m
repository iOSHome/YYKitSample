//
//  TLDifferentJSONKeyModel.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLDifferentJSONKeyModel.h"

@implementation TLDifferentJSONKeyModel

+ (NSDictionary *) modelCustomPropertyMapper {
    return @{@"UserID" : @"user_id",
             @"createdTime" : @"created_at"
             };
}

@end
