//
//  HAmountView.m
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HAmountView.h"

#define identify_cell @"cell"

#define identify_footer @"CollectionReusableViewFooter"
#define identify_header @"CollectionReusableViewHeader"

@interface HAmountView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HAmountView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        
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
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,10, self.frame.size.width,0) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    //    self.collectionView.
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[HCustomInputCell class] forCellWithReuseIdentifier:identify_cell];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify_header];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer];
    self.collectionView.allowsMultipleSelection=YES;
    
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor:[UIColor colorWithRed:254.0/255 green:93.0/255 blue:55.0/255 alpha:1]];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.centerX.equalTo(self);
        make.width.equalTo(@200);
        make.height.mas_equalTo(45);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextButtonClick:(UIButton *)button{
    NSLog(@"提交了...");
}
- (void)setCollectionFrame{
    NSInteger hh = [NSString stringWithFormat:@"%f",ceilf(self.dataSourceArray.count/5.0)].integerValue * (25+10);
    self.collectionView.frame = CGRectMake(0, 10, self.frame.size.width, hh);
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
        reuseIdentifier = identify_footer;
    }else{
        reuseIdentifier = identify_header;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    return view;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemHeight=25;
    CGFloat itemWidth=self.frame.size.width/6;
    
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
    CGSize size={0,0};
    return size;
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
    
    HCustomInputCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify_cell forIndexPath:indexPath];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",self.dataSourceArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [NSString stringWithFormat:@"%@",self.dataSourceArray[indexPath.row]]);
    [self.collectionView reloadData];
}

@end
