//
//  HCustomInputCell.m
//  TestLoyout
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HCustomInputCell.h"

@implementation HCustomInputCell

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewSetUp];
    }
    return self;
}
#pragma mark view
-(void)viewSetUp{
    
    self.backgroundColor=[UIColor whiteColor];

    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.1,0, self.frame.size.width*0.8, self.frame.size.height)];
    self.titleLabel.backgroundColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.textColor=[UIColor grayColor];
    [self addSubview:self.titleLabel];
}

@end
