//
//  MXCollectionMainCell.h
//  collectionView瀑布流
//
//  Created by yww on 15/9/12.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXCollectionMainCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (void)cellSetTltleWith:(NSIndexPath*)indexPath;
@end
