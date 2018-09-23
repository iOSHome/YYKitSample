//
//  TLDefineChangeVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/23.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLDefineChangeVC.h"
#import "TLPersonModel.h"

@interface TLDefineChangeVC ()

@end

@implementation TLDefineChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLDefineChangeVC.m";
    [self.view addSubview:label];
    
    [self defineChangeModelConvert];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defineChangeModelConvert {
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
                                  },
                          @"eats":@[
                                  @{@"food":@"西瓜",@"date":@"8点"},
                                  @{@"food":@"烤鸭",@"date":@"14点"},
                                  @{@"food":@"西餐",@"date":@"20点"}
                                  ]
                          };
    TLPersonModel *model = [TLPersonModel yy_modelWithDictionary:dic];
    for (TLEatModel *eat in model.eats) {
        NSLog(@"%@-%@",eat.food,eat.date);
    }
}

@end
