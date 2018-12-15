//
//  HPayMethodView.h
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HPayMethodCollectionViewBlock)(NSInteger index);

@interface HPayMethodView : UICollectionReusableView

/**
 数据源
 */
@property(strong,nonatomic)NSMutableArray *dataSourceArray;
@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)UICollectionView *collectionView;

@property (nonatomic, copy) HPayMethodCollectionViewBlock paymethodBlock;

- (void)setCollectionFrame;

@end

