//
//  TLMemoryCache.h
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLMemoryCache;

typedef void(^TLMemoryCacheObjectBlock)(TLMemoryCache *memoryCache, NSString *key, id object);

@interface TLMemoryCache : NSObject

+(instancetype)sharedInstance;

- (void)objectForKey:(NSString *)key block:(TLMemoryCacheObjectBlock)block;

-(void)setObject:(id)object forKey:(NSString *)key block:(TLMemoryCacheObjectBlock)block;

-(void)removeObjectForKey:(NSString *)key;

@end
