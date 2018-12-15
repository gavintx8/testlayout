//
//  HPayMethodView.m
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HPayMethodView.h"

#define identify_cell @"cell"

#define identify_footer @"CollectionReusableViewFooter"
#define identify_footer2 @"CollectionReusableViewFooter2"
#define identify_header @"CollectionReusableViewHeader"

@interface HPayMethodView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HPayMethodView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        [self viewSetUp];
    }
    return self;
}

#pragma mark UI
/**
 UI
 */
-(void)viewSetUp{

    //创建流式布局
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
 
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    //设置滑动方向
    // flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //指定边距
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 0,0, 0);
    //创建集合视图
    
    
    //    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0.5*itemWidth,1*itemHeight, 7*itemWidth,6*itemHeight) collectionViewLayout:flowLayout];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,10, self.frame.size.width,200) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    //    self.collectionView.
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[HPayMethodCell class] forCellWithReuseIdentifier:identify_cell];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify_header];
    [self.collectionView registerClass:[HAmountView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer];
    [self.collectionView registerClass:[HCustomInputView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer2];
    self.collectionView.allowsMultipleSelection=YES;
    
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
}
- (void)setCollectionFrame{
    NSInteger hh = [NSString stringWithFormat:@"%f",ceilf(self.dataArr.count/5.0)].integerValue * (25+10) + 55;
    NSInteger hh2 = [NSString stringWithFormat:@"%f",ceilf(self.dataSourceArray.count/3.0)].integerValue * (30+10);
    self.collectionView.frame = CGRectMake(0, 10, self.frame.size.width, hh+hh2);
}
#pragma mark collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier=identify_cell;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        if (self.dataArr.count == 1) {
            reuseIdentifier = identify_footer2;
        }else{
            reuseIdentifier = identify_footer;
        }
    }else{
        reuseIdentifier = identify_header;
    }
    if (self.dataArr.count == 1) {
        HCustomInputView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        
        NSInteger hh = 150;
        NSInteger hh2 = [NSString stringWithFormat:@"%f",ceilf(self.dataSourceArray.count/3.0)].integerValue * (30+10);
        self.collectionView.frame = CGRectMake(0, 10, self.frame.size.width, hh+hh2);
        
        return view;
    }else{
        HAmountView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.dataSourceArray = [self.dataArr mutableCopy];
        [view setCollectionFrame];
        [view.collectionView reloadData];
        return view;
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemHeight=30;
    CGFloat itemWidth=self.frame.size.width/4;
    
    return CGSizeMake(itemWidth, itemHeight);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.dataArr.count == 1) {
        CGSize size={self.collectionView.frame.size.width,150};
        return size;
    }else{
        NSInteger hh = [NSString stringWithFormat:@"%f",ceilf(self.dataArr.count/5.0)].integerValue * (25+10) + 55;
        CGSize size={self.collectionView.frame.size.width,hh};
        return size;
    }
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HPayMethodCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify_cell forIndexPath:indexPath];
    cell.titleLabel.text=[NSString stringWithFormat:@"支付%ld",indexPath.row+1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSourceArray[indexPath.row];
    self.dataArr = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"amountlist"]] componentsSeparatedByString:@","];
    [self setCollectionFrame];
    [self.collectionView reloadData];
    
    if (self.paymethodBlock) {
        self.paymethodBlock(indexPath.row);
    }
}

@end
