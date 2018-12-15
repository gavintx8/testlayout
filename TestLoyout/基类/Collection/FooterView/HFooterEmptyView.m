//
//  HFooterEmptyView.m
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HFooterEmptyView.h"

@implementation HFooterEmptyView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor brownColor]];
        
        [self viewSetUp];
    }
    return self;
}

#pragma mark UI
/**
 UI
 */
-(void)viewSetUp{
    UIButton *tipButton = [self createButtonTag:@"没有可用支付商列表！" and:104];
    [self addSubview:tipButton];
    [tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(35);
    }];
}

- (UIButton *)createButtonTag:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    
    return btn;
}

@end
