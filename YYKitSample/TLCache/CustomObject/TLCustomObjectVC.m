//
//  TLCustomObjectVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/19.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLCustomObjectVC.h"
#import "TLArticleCacheModel.h"

@interface TLCustomObjectVC ()

@end

@implementation TLCustomObjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(kScreenWidth, 30);
    label.centerY = self.view.height / 2 - (kiOS7Later ? 0 : 32);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"See code in TLCustomObjectVC.m";
    [self.view addSubview:label];
    
    // 将自定义的对象用YYCache储存到本地
    [self saveCustomObjectExample];
    [self readCustomObjectExample];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCustomObjectExample {
    YYCache *_dataCache =[[YYCache alloc] initWithName:@"ArticleCache"];
    _dataCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
    
    TLArticleCacheModel *cacheModel = [TLArticleCacheModel shareInstace];
    
    cacheModel.articleID = 110001;
    cacheModel.articleTitle = @"文章标题";
    cacheModel.imageUrl = @"图片地址";
    cacheModel.authorName = @"作者名字";
    //存储到本地
    [_dataCache setObject: cacheModel forKey:@"cacheModelKey"];
}

- (void)readCustomObjectExample {
    YYCache *_dataCache =[[YYCache alloc] initWithName:@"ArticleCache"];
    TLArticleCacheModel  *cacheModel = (TLArticleCacheModel *)[_dataCache objectForKey:@"cacheModelKey"];
    
    NSLog(@"from local get: %@",cacheModel);
}


@end
