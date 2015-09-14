//
//  ViewController.m
//  collectionView瀑布流
//
//  Created by yww on 15/9/12.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import "ViewController.h"
#import "MXCollectionHeadCell.h"
#import "MXCollectionMainCell.h"
#define MXRandomColor  [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0]
#define MXWidth [UIScreen mainScreen].bounds.size.width
#define MXHeight [UIScreen mainScreen].bounds.size.height
#define MXCellWidth (MXWidth - 30)/2


static NSString *indentifierMain = @"MXCollectionMainCell";
static NSString *indentifierhead = @"MXCollectionHeadCell";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
//存储所有的高度的数组
@property (strong,nonatomic) NSMutableArray  *heightArray;
//随机数组
@property(nonatomic,strong)NSMutableArray *randomNum;
//当前最高高度
@property(nonatomic,assign)CGFloat totalHeight;


@property(nonatomic,strong)UICollectionViewCell *lastCell;

@property(nonatomic,assign)CGFloat offset;
@end

@implementation ViewController
- (NSMutableArray *)heightArray
{
    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
- (NSMutableArray *)randomNum
{
    if (_randomNum == nil) {
        _randomNum = [NSMutableArray array];
    }
    return _randomNum;
}
- (void)viewDidAppear:(BOOL)animated
{
//    NSLog(@"福啊");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView.collectionViewLayout = flowLayout;
    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    //注册
    UINib *mainNib = [UINib nibWithNibName:indentifierMain
                                bundle: [NSBundle mainBundle]];
    [self.collectionView registerNib:mainNib forCellWithReuseIdentifier:indentifierMain];
    
    
    UINib *headNib = [UINib nibWithNibName:indentifierhead
                                bundle: [NSBundle mainBundle]];
    [self.collectionView registerNib:headNib forCellWithReuseIdentifier:indentifierhead];
//
    //随机获得五个由小到大的一定范围的数
//    [self getRandomNum:self.cellNumber];
    
}
- (void)getRandomNum:(NSInteger)cellNumber
{
    NSInteger Max = MAXFLOAT / 1.0;
    for (int i = 0; i <= Max; i ++)
    {
        NSInteger num = arc4random_uniform(50);
        [self.randomNum addObject:@(num)];
        if (self.randomNum.count == 5)
        {
            return;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"啊哈哈");
    //当前行列数
    NSInteger currentColumn = indexPath.row % 2;
    NSInteger currentRow = indexPath.row / 2;
    //当前高度
    CGFloat   currentHeight = [self.heightArray[indexPath.row] floatValue];
    
    // cell的位置设置
    CGFloat cellX=( MXCellWidth + (MXWidth - 2 *MXCellWidth) / 3) * currentColumn + (MXWidth - 2 *MXCellWidth) / 3;
    CGFloat cellY=(currentRow + 1) * 10 + 30;
        for (NSInteger i = 0; i<currentRow; i++) {
            NSInteger cellNum = currentColumn + i * 2;
            cellY += [self.heightArray[cellNum] floatValue];
        }
    self.totalHeight = cellY;
       CGRect cellFrame = CGRectMake(cellX, cellY, MXCellWidth, currentHeight);
//     CGRect frame = [self.collectionView convertRect:cellFrame toView:self.view];
    if (indexPath.row % 7 == 0)
    {
        MXCollectionHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierhead forIndexPath:indexPath];
        
        // 设置frame
        cell.tag = indexPath.row;
        cell.frame = cellFrame;
        [cell cellSetTltleWith:indexPath];
        
        return cell;
    }else
    {
        MXCollectionMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifierMain forIndexPath:indexPath];
        
        // 设置frame
         cell.tag = indexPath.row;
        cell.frame = cellFrame;
        [cell cellSetTltleWith:indexPath];
        
        return cell;

    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=150 + (arc4random() % 150);
        if (indexPath.row % 7 == 0)
        {
            [self.heightArray addObject:[NSString stringWithFormat:@"%f",40.0]];
            return CGSizeMake((MXWidth - 30)/2, 40);
        }else
        {
            [self.heightArray addObject:[NSString stringWithFormat:@"%f",height]];
            return  CGSizeMake((MXWidth - 30)/2, height);

        }
}
#pragma mark - UICollectionViewDelegateFlowLayout
//监听点击的cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"row = %lu",indexPath.row);
}

//返回cell的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,(MXWidth - 2 *MXCellWidth) / 3, 10, (MXWidth - 2 *MXCellWidth) / 3);
}

//组头间隔
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(MXCellWidth, 30);
    }else
        return CGSizeMake(MXCellWidth, 10);
}

#pragma mark - scrollView方法
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   
    CGFloat offset = scrollView.contentOffset.y;
    self.offset = offset;
    NSLog(@"offset = %f",offset);
    NSArray *cellArray = [self.collectionView visibleCells];
    UICollectionViewCell *cell = [cellArray lastObject];
    CGFloat height = [self.heightArray[cell.tag] floatValue];
    self.lastCell = cell;
   
    
    NSInteger currentColumn = cell.tag % 2;
    NSInteger currentRow = cell.tag / 2;
   //获得当前cell的最大y值
    CGFloat cellY=(currentRow + 1) * 10 + 30;
    for (NSInteger i = 0; i<currentRow; i++) {
        NSInteger cellNum = currentColumn + i * 2;
        cellY += [self.heightArray[cellNum] floatValue];
    }
    CGFloat totalHeight = cellY ;
    CGFloat cha = - totalHeight + offset;
    if (cha >= 0) {
        self.view.transform = CGAffineTransformMakeScale(0, 1 +cha/offset);
        self.view.transform = CGAffineTransformMakeTranslation(0, height);
    }else
    {
        self.view.transform = CGAffineTransformMakeScale(0, 1 +cha/offset);
        self.view.transform =CGAffineTransformMakeTranslation(0, -height);
    }
    [scrollView setNeedsUpdateConstraints];
}
 */


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat value = - self.totalHeight + offset;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

@end
