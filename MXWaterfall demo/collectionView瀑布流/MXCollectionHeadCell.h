//
//  MXCollectionHeadCell.h
//  collectionView瀑布流
//
//  Created by yww on 15/9/12.
//  Copyright (c) 2015年 yww. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXCollectionHeadCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekTitleLabel;
- (void)cellSetTltleWith:(NSIndexPath*)indexPath;
@end
