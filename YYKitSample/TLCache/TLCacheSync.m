//
//  TLCacheSync.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCacheSync.h"

@interface TLCacheSync ()

@end

@implementation TLCacheSync

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLCacheSync.m";
    [self.view addSubview:label];
    
    [self runSyncExample];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runSyncExample {
    //模拟数据
    NSString *value=@"I want to know who is licj ?";
    //模拟一个key
    //同步方式
    NSString *key=@"key";
    YYCache *yyCache=[YYCache cacheWithName:@"LICJCacheSync"];
    //根据key写入缓存value
    [yyCache setObject:value forKey:key];
    //判断缓存是否存在
    BOOL isContains=[yyCache containsObjectForKey:key];
    NSLog(@"containsObject : %@", isContains?@"YES":@"NO");
    //根据key读取数据
    id vuale=[yyCache objectForKey:key];
    NSLog(@"value : %@",vuale);
    //根据key移除缓存
    [yyCache removeObjectForKey:key];
    //移除所有缓存
    [yyCache removeAllObjects];
}

@end
