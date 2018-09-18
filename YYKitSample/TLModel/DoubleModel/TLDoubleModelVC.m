//
//  TLDoubleModelVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLDoubleModelVC.h"
#import "TLBookModel.h"

@interface TLDoubleModelVC ()

@end

@implementation TLDoubleModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLDoubleModelVC.m";
    [self.view addSubview:label];
    
    [self DoubleModelJsonModelConvert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom Method
//读取本地json,获取json数据
- (NSDictionary *) getJsonWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (void)DoubleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"TLDoubleModel"];
    
    // Convert json to model:
    TLBookModel *book = [TLBookModel yy_modelWithDictionary:json];
    NSLog(@"book ===== %@",book);
    
    // Convert model to json:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}

@end
