//
//  TLArticleCacheModel.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/19.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLArticleCacheModel.h"

@implementation TLArticleCacheModel

+(instancetype)shareInstace {
    
    static dispatch_once_t onceToken;
    // 用来保存唯一的单例对象
    static id _instace;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.articleID forKey:@"articleID"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
    [aCoder encodeObject:self.articleTitle forKey:@"articleTitle"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.articleID = [aDecoder decodeIntForKey:@"articleID"];
    self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
    self.articleTitle = [aDecoder decodeObjectForKey:@"articleTitle"];
    self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
    
    return self;
}

@end
