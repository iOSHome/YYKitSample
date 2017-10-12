//
//  TLDiskCache.h
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLDiskCache;
typedef void(^TLDiskCacheObjectBlock)(TLDiskCache *diskCache, NSString *key, id object);

@interface TLDiskCache : NSObject

+(instancetype)sharedInstance;

- (instancetype)initWithName:(NSString *)name;

-(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

- (void)objectForKey:(NSString *)key block:(TLDiskCacheObjectBlock)block;

-(void)setObject:(id)object forKey:(NSString *)key block:(TLDiskCacheObjectBlock)block;

-(void)removeObjectForKey:(NSString *)key;

@end
