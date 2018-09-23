//
//  TLPersonModel.h
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/23.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLEatModel : NSObject

@property (copy, nonatomic)NSString *food;
@property (copy, nonatomic)NSString *date;

@end

@interface TLPersonModel : NSObject

@property (strong, nonatomic) NSNumber *personId;
@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) int age;
@property (copy,   nonatomic) NSString *sex;
@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSDictionary *job;
@property (strong, nonatomic) NSArray <TLEatModel *> *eats;

@end

