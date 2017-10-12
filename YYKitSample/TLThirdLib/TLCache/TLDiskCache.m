//
//  TLDiskCache.m
//  YYKitSample
//
//  Created by lichuanjun on 2017/10/11.
//  Copyright © 2017年 lichuanjun. All rights reserved.
//

#import "TLDiskCache.h"

static NSString const *TLDiskCachePrefix = @"com.leecj.TLDiskCache";

@interface TLDiskCache()

@property (nonatomic, strong) dispatch_queue_t currentQueue;

@property (strong, nonatomic) dispatch_semaphore_t lockSemaphore;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSURL *cacheUrl;
@end

@implementation TLDiskCache

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
        _name = [name copy];
        
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"%@ Asynchronous Queue", TLDiskCachePrefix] UTF8String], DISPATCH_QUEUE_CONCURRENT);
        
        _lockSemaphore = dispatch_semaphore_create(1);
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *pathComponment = [NSString stringWithFormat:@"%@.%@", TLDiskCachePrefix, name];
        _cacheUrl = [NSURL fileURLWithPathComponents:@[rootPath, pathComponment]];
    }
    return self;
}


- (void)setObject:(id)object forKey:(NSString *)key block:(TLDiskCacheObjectBlock)block {
    if (!key || !object) {
        return;
    }
    
    __weak TLDiskCache *weakSelf= self;
    dispatch_sync(_currentQueue, ^{
        NSURL *fileUrl = nil;
        dispatch_semaphore_wait(_lockSemaphore, DISPATCH_TIME_FOREVER);
        fileUrl = [self encodedFileURLForKey:key];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        NSError *writeErr = nil;
        BOOL written = [data writeToURL:fileUrl options:NSDataWritingAtomic error:&writeErr];
        if (!written) {
            fileUrl = nil;
        }
        dispatch_semaphore_signal(_lockSemaphore);
        
        if (block) {
            block(weakSelf, key, object);
        }
    });
}

- (void)objectForKey:(NSString *)key block:(TLDiskCacheObjectBlock)block {
    if (!key) {
        return;
    }
    
    dispatch_sync(_currentQueue, ^{
        __weak TLDiskCache *weakSelf = self;
        id object = [weakSelf objectForKey:key];
        if (block) {
            block(weakSelf, key, object);
        }
    });
}

- (id)objectForKey:(NSString *)key {
    
    NSURL *fileUrl = nil;
    
    id object = nil;
    dispatch_semaphore_wait(_lockSemaphore, DISPATCH_TIME_FOREVER);
    
    fileUrl = [self encodedFileURLForKey:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileUrl path]]) {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:[fileUrl path]];
    }
    
    dispatch_semaphore_signal(_lockSemaphore);
    return object;
}

-(void)removeObjectForKey:(NSString *)key {
    if (!key) {
        return;
    }
    
    dispatch_semaphore_wait(_lockSemaphore, DISPATCH_TIME_FOREVER);
    NSURL *fileUrl = [self encodedFileURLForKey:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileUrl path]]) {
        
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[fileUrl path] error:&error];
        if (error) {
            NSLog(@"File delete error:%@",error.description);
        }
    }
    
    dispatch_semaphore_signal(_lockSemaphore);
}

- (NSURL *)encodedFileURLForKey:(NSString *)key {
    if (![key length]) {
        return nil;
    }
    
    return [_cacheUrl URLByAppendingPathComponent:[self encodedString:key]];
}

- (NSString *)encodedString:(NSString *)string
{
    if (![string length]) {
        return @"";
    }
    
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@".:/%"] invertedSet]];
}

@end
