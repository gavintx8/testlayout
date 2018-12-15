//
//  HCustomInputView.m
//  TestLoyout
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HCustomInputView.h"

#define cellid @"cell2"

#define identify_footer @"CollectionReusableViewFooter"
#define identify_header @"CollectionReusableViewHeader"

@interface HCustomInputView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)UITextField *amountTextField;

@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceAmount;

@end

@implementation HCustomInputView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor brownColor]];
        
        self.dataSourceAmount = @[@"50", @"100", @"200", @"300", @"500"].mutableCopy;
        
        [self viewSetUp];
    }
    return self;
}

#pragma mark UI
/**
 UI
 */
-(void)viewSetUp{
    UILabel *amountTitleLabel = [[UILabel alloc] init];
    amountTitleLabel.text = @"金额";
    amountTitleLabel.font = [UIFont systemFontOfSize:14.f];
    amountTitleLabel.textColor = [UIColor blackColor];
    [self addSubview:amountTitleLabel];
    [amountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.height.mas_equalTo(20);
    }];
    
    self.amountTextField = [[UITextField alloc] init];
    self.amountTextField.placeholder = @"请输入金额";
    self.amountTextField.font = [UIFont systemFontOfSize:14.f];
    self.amountTextField.textColor = [UIColor blackColor];
    self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.amountTextField];
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountTitleLabel.mas_right).offset(10);
        make.centerY.equalTo(amountTitleLabel);
        make.height.mas_equalTo(30);
        make.width.equalTo(@200);
    }];
    
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
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, self.frame.size.width,40) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    //    self.collectionView.
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[HCustomInputCell class] forCellWithReuseIdentifier:cellid];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify_header];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer];
    self.collectionView.allowsMultipleSelection=YES;
    
    [self.collectionView setBackgroundColor:[UIColor brownColor]];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor:[UIColor colorWithRed:254.0/255 green:93.0/255 blue:55.0/255 alpha:1]];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(@200);
        make.height.mas_equalTo(45);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextButtonClick:(UIButton *)button{
    NSLog(@"提交...");
}
#pragma mark collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceAmount.count;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier=cellid;
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
    CGFloat itemHeight=30;
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
    
    HCustomInputCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",self.dataSourceAmount[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.amountTextField.text = [NSString stringWithFormat:@"%@",self.dataSourceAmount[indexPath.row]];
    [self.collectionView reloadData];
}

@end
