//
//  MXCollectionHeadCell.m
//  collectionView瀑布流
//
//  Created by yww on 15/9/12.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import "MXCollectionHeadCell.h"
#define MXRandomColor  [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0]

@interface MXCollectionHeadCell () 
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *lakeView;

@end
@implementation MXCollectionHeadCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)cellSetTltleWith:(NSIndexPath*)indexPath
{
//      NSLog( @"section = %lu row = %lu",indexPath.section,indexPath.row);
    self.backView.backgroundColor = [UIColor redColor];
    self.backgroundView.layer.cornerRadius = 5;
    self.lakeView.layer.cornerRadius = 5;
    self.weekTitleLabel.textColor = [UIColor blackColor];
    self.weekTitleLabel.font = [UIFont systemFontOfSize:17];
    self.weekTitleLabel.text = [NSString stringWithFormat:@"星期%lu",indexPath.row / 7 + 1];
//    self.weekTitleLabel.text = [NSString stringWithFormat:@"星期%lu",(indexPath.section / 2 + 1) % 7];
}
@end
