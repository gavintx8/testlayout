//
//  HAmountView.h
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAmountView : UICollectionReusableView

/**
 数据源
 */
@property(strong,nonatomic)NSMutableArray *dataSourceArray;

@property(strong,nonatomic)UICollectionView *collectionView;

- (void)setCollectionFrame;

@end
