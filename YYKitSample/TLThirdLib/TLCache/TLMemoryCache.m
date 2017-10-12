//
//  TLMemoryCache.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLMemoryCache.h"
#import <pthread/pthread.h>

@interface TLMemoryCache()

@property (nonnull,strong) NSMutableDictionary *cacheDic;

@property (nonatomic, strong) dispatch_queue_t currentQueue;

@property (nonatomic, assign) pthread_mutex_t mutex;

@end

@implementation TLMemoryCache

+(instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    __unused int result = pthread_mutex_destroy(&_mutex);
    NSCAssert(result == 0, @"Failed to destroy lock in ZCJMemoryCache %p. Code: %d", (void *)self, result);
}

-(instancetype)init {
    self = [super init];
    if (self) {
        __unused int result = pthread_mutex_init(&_mutex, NULL);
        NSAssert(result == 0, @"Failed to init lock in ZCJMemoryCache %@. Code: %d", self, result);
        
        NSString *queueName = [NSString stringWithFormat:@"com.ZCJMemory.%p",(void *)self];
        _currentQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _cacheDic = [NSMutableDictionary new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)didReceiveEnterBackgroundNotification:(NSNotification *)notification {
    [self removeAllObjects];
}

- (void)didReceiveMemoryWarning:(NSNotification *)notification {
    [self removeAllObjects];
}

-(id)objectForKey:(NSString *)key {
    
    id object = nil;
    pthread_mutex_lock(&_mutex);
    object = _cacheDic[key];
    pthread_mutex_unlock(&_mutex);
    return object;
}

- (void)objectForKey:(NSString *)key block:(TLMemoryCacheObjectBlock)block{
    __weak TLMemoryCache *weakSelf = self;
    dispatch_async(_currentQueue, ^{
        id object = [weakSelf objectForKey:key];
        if (block) {
            block(weakSelf, key, object);
        }
    });
}

-(void)setObject:(id)object forKey:(NSString *)key block:(TLMemoryCacheObjectBlock)block {
    if (!key || !object) {
        return;
    }
    
    __weak TLMemoryCache *weakSelf = self;
    dispatch_sync(_currentQueue, ^{
        pthread_mutex_lock(&_mutex);
        [weakSelf.cacheDic setObject:object forKey:key];
        pthread_mutex_unlock(&_mutex);
        if (block) {
            block(weakSelf, key, object);
        }
    });
}

-(void)removeObjectForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    pthread_mutex_lock(&_mutex);
    [_cacheDic removeObjectForKey:key];
    pthread_mutex_unlock(&_mutex);
}

- (void)removeAllObjects {
    pthread_mutex_lock(&_mutex);
    [_cacheDic removeAllObjects];
    pthread_mutex_unlock(&_mutex);
}

@end
