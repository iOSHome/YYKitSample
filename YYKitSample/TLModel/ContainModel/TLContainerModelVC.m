//
//  TLContainerModelVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLContainerModelVC.h"
#import "TLContainerModel.h"

@interface TLContainerModelVC ()

@property(nonatomic,strong) NSArray *listArray;     //listArray

@end

@implementation TLContainerModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLContainerModelVC.m";
    [self.view addSubview:label];
    
    [self containerJsonModelConvert];
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

- (void)containerJsonModelConvert {
    NSDictionary *json =[self getJsonWithJsonName:@"TLContainerModel"];
    
    TLContainerModel *containModel = [TLContainerModel yy_modelWithDictionary:json];
    
    NSDictionary *dataDict = [containModel valueForKey:@"data"];
    
    self.listArray = [dataDict valueForKey:@"list"];
    
    //遍历数组获取里面的字典，在调用YYModel方法
    [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *listDict = obj;
        List *listModel = [List yy_modelWithDictionary:listDict];
        //随便获取count 和 id两个类型
        NSString *count = [listModel valueForKey:@"count"];
        NSString *idValue = [listModel valueForKey:@"id"];
        NSLog(@"count == %@,id === %@",count,idValue);
    }];
}


@end
