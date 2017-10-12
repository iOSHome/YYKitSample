//
//  TLCacheLRU.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCacheLRU.h"

@interface TLCacheLRU ()

@end

@implementation TLCacheLRU

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLCacheLRU.m";
    [self.view addSubview:label];
    
    [self runLRUExample];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runLRUExample {
    YYCache *yyCache=[YYCache cacheWithName:@"LICJCacheLRU"];
    [yyCache.memoryCache setCountLimit:50];//内存最大缓存数据个数
    [yyCache.memoryCache setCostLimit:1*1024];//内存最大缓存开销 目前这个毫无用处
    [yyCache.diskCache setCostLimit:10*1024];//磁盘最大缓存开销
    [yyCache.diskCache setCountLimit:50];//磁盘最大缓存数据个数
    [yyCache.diskCache setAutoTrimInterval:60];//设置磁盘lru动态清理频率 默认 60秒
    
    for(int i=0 ;i<100;i++){
        //模拟数据
        NSString *value=@"I want to know who is licj ?";
        //模拟一个key
        NSString *key=[NSString stringWithFormat:@"key%d",i];
        [yyCache setObject:value forKey:key];
    }
    
    NSLog(@"yyCache.memoryCache.totalCost:%lu",(unsigned long)yyCache.memoryCache.totalCost);
    NSLog(@"yyCache.memoryCache.costLimit:%lu",(unsigned long)yyCache.memoryCache.costLimit);
    
    NSLog(@"yyCache.memoryCache.totalCount:%lu",(unsigned long)yyCache.memoryCache.totalCount);
    NSLog(@"yyCache.memoryCache.countLimit:%lu",(unsigned long)yyCache.memoryCache.countLimit);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"yyCache.diskCache.totalCost:%lu",(unsigned long)yyCache.diskCache.totalCost);
        NSLog(@"yyCache.diskCache.costLimit:%lu",(unsigned long)yyCache.diskCache.costLimit);
        
        NSLog(@"yyCache.diskCache.totalCount:%lu",(unsigned long)yyCache.diskCache.totalCount);
        NSLog(@"yyCache.diskCache.countLimit:%lu",(unsigned long)yyCache.diskCache.countLimit);
        
        for(int i=0 ;i<100;i++){
            //模拟一个key
            NSString *key=[NSString stringWithFormat:@"whoislcj%d",i];
            id vuale=[yyCache objectForKey:key];
            NSLog(@"key ：%@ value : %@",key ,vuale);
        }
        
    });
}

@end
