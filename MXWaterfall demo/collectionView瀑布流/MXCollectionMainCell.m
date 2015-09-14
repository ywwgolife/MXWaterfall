//
//  MXCollectionMainCell.m
//  collectionView瀑布流
//
//  Created by yww on 15/9/12.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import "MXCollectionMainCell.h"
#define MXRandomColor  [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0]

@interface MXCollectionMainCell () 
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end
@implementation MXCollectionMainCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)cellSetTltleWith:(NSIndexPath*)indexPath
{
//          NSLog( @"section = %lu row = %lu",indexPath.section,indexPath.row);
    self.backView.backgroundColor = MXRandomColor;
    self.layerView.backgroundColor = MXRandomColor;
    self.backgroundView.layer.cornerRadius = 5;
    self.layerView.layer.cornerRadius = 5;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.text = [NSString stringWithFormat:@"第%lu个",indexPath.row - 1 - (indexPath.row / 7)];
//    self.titleLabel.text = [NSString stringWithFormat:@"%lu组 第%lu个",(indexPath.section - 1)/2,indexPath.row];

}
@end
