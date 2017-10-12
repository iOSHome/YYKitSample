//
//  YYCachePKPINCache.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLYYCachePKPINCache.h"

@interface TLYYCachePKPINCache ()

@end

@implementation TLYYCachePKPINCache

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLYYCachePKPINCache.m";
    [self.view addSubview:label];
    
    [self runYYWriteExample];
    [self runPINWriteExample];
    
    [self runYYReadExample];
    [self runPINReadExample];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runYYWriteExample {
    //模拟数据
    NSString *value=@"I want to know who is licj ?";
    //模拟一个key
    NSString *key=@"key";
    //YYCache
    YYCache *yyCache=[YYCache cacheWithName:@"YYLICJCache"];
    //写入数据
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    [yyCache setObject:value forKey:key withBlock:^{
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        
        NSLog(@" yyCache async setObject time cost: %0.5f", end - start);
    }];
    
    CFAbsoluteTime start1 = CFAbsoluteTimeGetCurrent();
    [yyCache setObject:value forKey:key];
    CFAbsoluteTime end1 = CFAbsoluteTimeGetCurrent();
    NSLog(@" yyCache sync setObject time cost: %0.5f", end1 - start1);
}

- (void)runYYReadExample {
    YYCache *yyCache=[YYCache cacheWithName:@"YYLICJCache"];
    //模拟一个key
    NSString *key=@"key";
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    //读取数据
    [yyCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        NSLog(@" yyCache async objectForKey time cost: %0.5f", end - start);
    }];
    
    CFAbsoluteTime start1 = CFAbsoluteTimeGetCurrent();
    [yyCache objectForKey:key];
    CFAbsoluteTime  end1 = CFAbsoluteTimeGetCurrent();
    NSLog(@" yyCache sync objectForKey time cost: %0.5f", end1 - start1);
}

- (void)runPINWriteExample {
    //PINCache
    //模拟数据
    NSString *value=@"I want to know who is licj ?";
    //模拟一个key
    NSString *key=@"key";
    PINCache *pinCache=[PINCache sharedCache];
    //写入数据
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    [pinCache setObject:value forKey:key block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        
        NSLog(@" pincache async setObject time cost: %0.5f", end - start);
    }];
    
    CFAbsoluteTime start1 = CFAbsoluteTimeGetCurrent();
    [pinCache setObject:value forKey:key];
    CFAbsoluteTime end1 = CFAbsoluteTimeGetCurrent();
    NSLog(@" pinCache sync setObject time cost: %0.5f", end1 - start1);
}

- (void)runPINReadExample {
    PINCache *pinCache=[PINCache sharedCache];
    //模拟一个key
    NSString *key=@"key";
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    //读取数据
    [pinCache objectForKey:key block:^(PINCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        NSLog(@" pincache async objectForKey time cost: %0.5f", end - start);
    }] ;
    
    CFAbsoluteTime start1 = CFAbsoluteTimeGetCurrent();
    [pinCache objectForKey:key];
    CFAbsoluteTime end1 = CFAbsoluteTimeGetCurrent();
    NSLog(@" pinCache objectForKey time cost: %0.5f", end1 - start1);
}

@end
