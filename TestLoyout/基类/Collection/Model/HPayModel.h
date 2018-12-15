//
//  HPayModel.h
//  TestLoyout
//
//  Created by mac on 2018/12/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPayModel : NSObject

@property(copy,nonatomic)NSString *paymentName;
@property(copy,nonatomic)NSString *pid;
@property(copy,nonatomic)NSString *amountlist;
@property(copy,nonatomic)NSString *minquota;
@property(copy,nonatomic)NSString *maxquota;

+(instancetype)cellModelWithDict:(NSDictionary *)dic;
- (instancetype)initWithDict:(NSDictionary *)dic;

@end
