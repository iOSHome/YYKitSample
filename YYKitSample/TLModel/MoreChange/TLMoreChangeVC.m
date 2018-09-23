//
//  TLMoreChangeVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/23.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLMoreChangeVC.h"
#import "YYPersonModel.h"

@interface TLMoreChangeVC ()

@end

@implementation TLMoreChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLMoreChangeVC.m";
    [self.view addSubview:label];
    
    [self moreChangeModelConvert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moreChangeModelConvert {
    NSDictionary *dic = @{
                          @"id":@"123",
                          @"name":@"张三",
                          @"age":@(12),
                          @"sexDic":@{@"sex":@"男"},
                          @"languages":@[
                                  @"汉语",@"英语",@"法语"
                                  ],
                          @"job":@{
                                  @"work":@"iOS开发",
                                  @"eveDay":@"10小时",
                                  @"site":@"软件园"
                                  }
                          };
    
    YYPersonModel *model = [YYPersonModel yy_modelWithDictionary:dic];
    
    NSLog(@"%@",model.sex);
}

@end
