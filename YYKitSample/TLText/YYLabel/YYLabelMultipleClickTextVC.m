//
//  YYLabelMultipleClickTextVC.m
//  YYKitSample
//
//  Created by lichuanjun on 2018/9/19.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "YYLabelMultipleClickTextVC.h"

@interface YYLabelMultipleClickTextVC ()

@end

@implementation YYLabelMultipleClickTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *agreementText = @"点击登录即表示已同意并同意《xxx用户协议》与《xxx隐私政策》";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:agreementText];
    text.yy_lineSpacing = 5;
    
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_color = [UIColor blueColor];
    [text yy_setTextHighlightRange:NSMakeRange(13, 9) color:[UIColor redColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"用户协议被点击了");
        
    }];
    
    [text yy_setTextHighlightRange:NSMakeRange(agreementText.length-9, 9) color:[UIColor redColor]  backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"隐私政策被点击了");
        
    }];
    
    YYLabel *agreementLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, 100, kScreenWidth-30, 100)];
    agreementLabel.numberOfLines = 0;
    agreementLabel.preferredMaxLayoutWidth = kScreenWidth-85;//最大宽度
    agreementLabel.attributedText = text;
    [self.view addSubview:agreementLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
