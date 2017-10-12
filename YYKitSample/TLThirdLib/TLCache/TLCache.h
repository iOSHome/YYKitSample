//
//  TLCache.h
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLCache;
typedef void(^TLCacheObjectBlock)(TLCache *cache, NSString *key, id object);

@interface TLCache : NSObject

+(instancetype)sharedInstance;

- (instancetype)initWithName:(NSString *)name;

//标记init方法不可用
-(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

//根据key异步取缓存数据
- (void)objectForKey:(NSString *)key block:(TLCacheObjectBlock)block;

//异步存储缓存数据
-(void)setObject:(id)object forKey:(NSString *)key block:(TLCacheObjectBlock)block;

//删除缓存数据
-(void)removeObjectForKey:(NSString *)key;

@end
