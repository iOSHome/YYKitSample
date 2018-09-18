//
//  TLBookModel.h
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLAuthorModel.h"

@interface TLBookModel : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, assign)NSUInteger pages;
@property TLAuthorModel *author; //TLBook 包含 TLAuthor 属性
//更改之后的name
//@property(nonatomic,strong)NSString *namePlus;

@end
