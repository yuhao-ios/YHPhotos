//
//  PhotoCell.h
//  YHCellDemo
//
//  Created by t4 on 17/5/4.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoCell;

@protocol PhotoCellDelegate <NSObject>

-(void)deleteThePhotoForCell:(PhotoCell *)cell  deleteBtn:(UIButton *)btn;

@end


@interface PhotoCell : UICollectionViewCell

/**图片视图*/
@property(nonatomic,strong)UIImageView *photoView;
/**删除按钮*/
@property(nonatomic,strong)UIButton *deleteBTn;

@property(nonatomic,weak) id <PhotoCellDelegate> delegate;

@end
