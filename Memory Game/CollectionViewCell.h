//
//  CollectionViewCell.h
//  Memory Game
//
//  Created by Sureshkumar Linganathan on 2/7/18.
//  Copyright © 2018 Impiger Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewCell;


@protocol CollectionViewCellDelegate<NSObject>

-(void)cellSelected:(CollectionViewCell*)cell;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *view;

-(void)setupView:(NSString*)string withViewBackgroundColor:(UIColor*)backgroundColor;
@property (nonatomic,weak)id<CollectionViewCellDelegate>delegate;

@end
