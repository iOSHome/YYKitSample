//
//  TLSimpleModelVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLSimpleModelVC.h"
#import "TLUserModel.h"

@interface TLSimpleModelVC ()

@end

@implementation TLSimpleModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLSimpleModelVC.m";
    [self.view addSubview:label];
    
    [self simpleModelJsonModelConvert];
}


#pragma mark - custom Method

//读取本地json,获取json数据
- (NSDictionary *) getJsonWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (NSArray *) getJsonArrayWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (void)simpleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"TLSimpleModel"];
    // Convert json to model:
    TLUserModel *simpleModel = [TLUserModel yy_modelWithDictionary:json];
    NSLog(@"%@",simpleModel);
    
    // Convert model to json:
    NSDictionary *jsonConvert = [simpleModel yy_modelToJSONObject];
    NSLog(@"%@",jsonConvert);
}

@end
