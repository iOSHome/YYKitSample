//
//  TLDifferentJSONKeyVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLDifferentJSONKeyVC.h"
#import "TLDifferentJSONKeyModel.h"

@interface TLDifferentJSONKeyVC ()

@end

@implementation TLDifferentJSONKeyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLDifferentJSONKeyVC.m";
    [self.view addSubview:label];
    
    
    [self DifferentJSONKeyModelConvert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom Method
//读取本地json,获取json数据
- (NSDictionary *)getJsonWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (void)DifferentJSONKeyModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"TLDifferentJSONKey"];
    
    // Convert json to model:
    TLDifferentJSONKeyModel *differentJsonKey = [TLDifferentJSONKeyModel yy_modelWithDictionary:json];
    
    // Convert model to json:
    NSDictionary *jsonDict = [differentJsonKey yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}


@end
