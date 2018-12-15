//
//  HPayModel.m
//  TestLoyout
//
//  Created by mac on 2018/12/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HPayModel.h"

@implementation HPayModel
- (instancetype)initWithDict:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.paymentName=dic[@"paymentName"];
        self.pid=dic[@"id"];
        self.amountlist=dic[@"amountlist"];
        self.minquota=dic[@"minquota"];
        self.maxquota=dic[@"maxquota"];
        //属性的名称的必须和字典<=
        //[self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+(instancetype)cellModelWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}
@end
