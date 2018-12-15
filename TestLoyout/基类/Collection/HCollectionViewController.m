//
//  HCollectionViewController.m
//  MyApp_HGB
//
//  Created by huangguangbao on 2017/10/26.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "HCollectionViewController.h"
#import "HGBCollectionViewCell.h"

#define identify_cell @"cell"

#define identify_footer @"CollectionReusableViewFooter"
#define identify_footer2 @"CollectionReusableViewFooter2"
#define identify_header @"CollectionReusableViewHeader"

@interface HCollectionViewController ()

@property(strong,nonatomic)NSArray *dataArr;

@property(assign,nonatomic)NSInteger selectindex;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceTitle;

@end

@implementation HCollectionViewController

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationItem];
    
    self.dataSourceTitle = @[@"微信支付", @"支付宝", @"网银支付", @"京东支付", @"快捷支付"].mutableCopy;
    self.selectindex = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"paylist1" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.dataSourceArray = [dict objectForKey:@"typeList"];
    
    NSDictionary *dic = self.dataSourceArray[0];
    self.dataArr = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"amountlist"]] componentsSeparatedByString:@","];
    
     [self viewSetUp];
}
#pragma mark 导航栏
//导航栏
-(void)createNavigationItem
{
    //导航栏
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:245.0/256 green:62.0/256 blue:42.0/256 alpha:1];
    //标题
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 136*wScale, 16)];
    titleLab.font=[UIFont boldSystemFontOfSize:16];
    titleLab.text=@"布局";
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.textColor=[UIColor whiteColor];
    self.navigationItem.titleView=titleLab;
}

#pragma mark UI
/**
 UI
 */
-(void)viewSetUp{
    self.view.backgroundColor = [UIColor colorWithRed:220.0/256 green:220.0/256 blue:220.0/256 alpha:1];

    //创建流式布局
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];

    flowLayout.minimumInteritemSpacing=0;
    flowLayout.minimumLineSpacing=0;
    //设置滑动方向
    // flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //指定边距
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 0,0, 0);
    //创建集合视图

    //    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0.5*itemWidth,2*itemHeight, 7*itemWidth,6*itemHeight) collectionViewLayout:flowLayout];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(20,10, kWidth - 40,kHeight - 100) collectionViewLayout:flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    //    self.collectionView.
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[HPayTypeCell class] forCellWithReuseIdentifier:identify_cell];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify_header];
    [self.collectionView registerClass:[HPayMethodView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer];
    [self.collectionView registerClass:[HFooterEmptyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identify_footer2];
    self.collectionView.allowsMultipleSelection=YES;
    
    self.collectionView.backgroundColor = [UIColor blackColor];
}
- (void)setCollectionFrame:(NSInteger)selectindex{
    self.selectindex = selectindex;
    NSDictionary *dic = self.dataSourceArray[selectindex];
    self.dataArr = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"amountlist"]] componentsSeparatedByString:@","];
    
//    NSInteger hh = [NSString stringWithFormat:@"%f",ceilf(self.dataArr.count/5.0)].integerValue * (25+10);
//    NSInteger hh2 = [NSString stringWithFormat:@"%f",ceilf(self.dataSourceArray.count/3.0)].integerValue * (30+10);
//    self.collectionView.frame = CGRectMake(0, 10, kWidth - 40, hh+hh2);
}
#pragma mark collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier=identify_cell;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        if (self.dataSourceArray == nil) {
            reuseIdentifier = identify_footer2;
        }else{
            reuseIdentifier = identify_footer;
        }
    }else{
        reuseIdentifier = identify_header;
    }
    if (self.dataSourceArray == nil) {
        HFooterEmptyView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        return view;
    }else{
        HPayMethodView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
        view.dataSourceArray = self.dataSourceArray;
        
        NSDictionary *dicInit = self.dataSourceArray[self.selectindex];
        view.dataArr = [[NSString stringWithFormat:@"%@",[dicInit objectForKey:@"amountlist"]] componentsSeparatedByString:@","];
        [view setCollectionFrame];
        [view.collectionView reloadData];
        
        [view setPaymethodBlock:^(NSInteger index) {
            [self setCollectionFrame:index];
            [self.collectionView reloadData];
        }];
        
        return view;
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemHeight=40;
    CGFloat itemWidth=self.view.frame.size.width/2.5;

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
    if (self.dataSourceArray == nil) {
        CGSize size={self.collectionView.frame.size.width,50};
        return size;
    }else{
        NSInteger hh = [NSString stringWithFormat:@"%f",ceilf(self.dataArr.count/5.0)].integerValue * (25+10) + 55;
        if (self.dataArr.count == 1) {
            hh = 150;
        }
        NSInteger hh2 = [NSString stringWithFormat:@"%f",ceilf(self.dataSourceArray.count/3.0)].integerValue * (30+10);
        CGSize size={self.collectionView.frame.size.width,hh+hh2};
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
    
    HPayTypeCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify_cell forIndexPath:indexPath];
    cell.titleLabel.text=self.dataSourceTitle[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filename = @"";
    if(indexPath.row == 0){
        filename = @"paylist1";
    }else if(indexPath.row == 1){
        filename = @"paylist2";
    }else if(indexPath.row == 2){
        filename = @"paylist3";
    }else if(indexPath.row == 3){
        filename = @"paylist4";
    }else if(indexPath.row == 4){
        filename = @"paylist5";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.dataSourceArray = [dict objectForKey:@"typeList"];
    
    self.selectindex = 0;
    
    NSDictionary *dic = self.dataSourceArray[0];
    self.dataArr = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"amountlist"]] componentsSeparatedByString:@","];
    
    [self.collectionView reloadData];
}

@end
