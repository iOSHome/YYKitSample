//
//  TLArticleCacheModel.h
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/19.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLArticleCacheModel : NSObject<NSCoding>

+ (instancetype)shareInstace;

@property(nonatomic, copy) NSString *articleTitle;
@property(nonatomic, copy) NSString *imageUrl;
@property(nonatomic, copy) NSString *authorName;
@property(nonatomic, assign) NSInteger articleID;

@end
