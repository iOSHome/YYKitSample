//
//  YYModelExample.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/18.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "YYModelExample.h"

@interface YYModelExample ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation YYModelExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"YYModel";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"SimpleModel(简单的数据模型)" class:@"TLSimpleModelVC"];
    [self addCell:@"DoubleModel(双模型)" class:@"TLDoubleModelVC"];
    [self addCell:@"DifferentJSONKey(键值和属性不同)" class:@"TLDifferentJSONKeyVC"];
    [self addCell:@"Container Property(容器模型)" class:@"TLContainerModelVC"];
    [self addCell:@"WhiteList&BlackList(黑白名单)" class:@"TLBlacklistAndWhitelistVC"];
    [self addCell:@"TimeStamp" class:@"TLTimestampVC"];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYModelExample"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYModelExample"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
