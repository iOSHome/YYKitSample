//
//  TLCache.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLCache.h"
#import "TLMemoryCache.h"
#import "TLDiskCache.h"

static NSString * const TLCachePrefix = @"com.leecj.TLCache";

@interface TLCache()

@property (nonatomic, strong) TLMemoryCache *memoryCache;

@property (nonatomic, strong) TLDiskCache *diskCache;

@property (nonatomic, strong) dispatch_queue_t currentQueue;

@end

@implementation TLCache

+(instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithName:@"TLDiskCacheShared"];
    });
    return instance;
}


-(instancetype)initWithName:(NSString *)name {
    if (!name) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _diskCache = [[TLDiskCache alloc] initWithName:name];
        _memoryCache = [[TLMemoryCache alloc] init];
        
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.%p", TLCachePrefix, (void *)self];
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@ Asynchronous Queue", queueName] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        
    }
    return self;
}

-(void)setObject:(id)object forKey:(NSString *)key block:(TLCacheObjectBlock)block {
    if (!key || !object) {
        return;
    }
    
    //向group追加任务队列，如果所有的任务都执行或者超时，它发出通知
    dispatch_group_t group = nil;
    TLMemoryCacheObjectBlock memBlock = nil;
    TLDiskCacheObjectBlock diskBlock = nil;
    
    if (block) {
        group = dispatch_group_create();
        dispatch_group_enter(group);
        dispatch_group_enter(group);
        
        memBlock = ^(TLMemoryCache *memoryCache, NSString *memoryCacheKey, id memoryCacheObject) {
            dispatch_group_leave(group);
        };
        
        diskBlock = ^(TLDiskCache *diskCache, NSString *key, id object) {
            dispatch_group_leave(group);
        };
    }
    [_memoryCache setObject:object forKey:key block:memBlock];
    [_diskCache setObject:object forKey:key block:diskBlock];
    
    if (group) {
        __weak TLCache *weakSelf = self;
        dispatch_group_notify(group, _currentQueue, ^{
            TLCache *strongSelf = weakSelf;
            if (strongSelf)
                block(strongSelf, key, object);
        });
    }
}

- (void)objectForKey:(NSString *)key block:(TLCacheObjectBlock)block {
    if (!key) {
        return;
    }
    
    __weak TLCache *weakSelf = self;
    dispatch_sync(_currentQueue, ^{
        TLCache *strongSelf = weakSelf;
        [strongSelf.memoryCache objectForKey:key block:^(TLMemoryCache *memoryCache, NSString *key, id object) {
            if (object) {
                dispatch_sync(_currentQueue, ^{
                    TLCache *strongSelf = weakSelf;
                    block(strongSelf, key, object);
                });
            }
            else {
                [strongSelf.diskCache objectForKey:key block:^(TLDiskCache *diskCache, NSString *key, id object) {
                    if (object) {
                        dispatch_sync(_currentQueue, ^{
                            TLCache *strongSelf = weakSelf;
                            block(strongSelf, key, object);
                        });
                    }
                }];
            }
        }];
    });
}

-(void)removeObjectForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

@end
