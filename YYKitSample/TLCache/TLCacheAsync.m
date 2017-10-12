//
//  TLCacheAsync.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCacheAsync.h"

@interface TLCacheAsync ()

@end

@implementation TLCacheAsync

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLCacheAsync.m";
    [self.view addSubview:label];
    
    [self runAsyncExample];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runAsyncExample {
    //模拟数据
    NSString *value=@"I want to know who is licj ?";
    //模拟一个key
    //异步方式
    NSString *key=@"key";
    YYCache *yyCache=[YYCache cacheWithName:@"LICJCacheAsync"];
    //根据key写入缓存value
    [yyCache setObject:value forKey:key withBlock:^{
        NSLog(@"setObject sucess");
    }];
    //判断缓存是否存在
    [yyCache containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"containsObject : %@", contains?@"YES":@"NO");
    }];
    
    //根据key读取数据
    [yyCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"objectForKey : %@",object);
    }];
    
    //根据key移除缓存
    [yyCache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
        NSLog(@"removeObjectForKey %@",key);
    }];
    //移除所有缓存
    [yyCache removeAllObjectsWithBlock:^{
        NSLog(@"removeAllObjects sucess");
    }];
    
    //移除所有缓存带进度
    [yyCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        NSLog(@"removeAllObjects removedCount :%d  totalCount : %d",removedCount,totalCount);
    } endBlock:^(BOOL error) {
        if(!error){
            NSLog(@"removeAllObjects sucess");
        }else{
            NSLog(@"removeAllObjects error");
        }
    }];
}

@end
