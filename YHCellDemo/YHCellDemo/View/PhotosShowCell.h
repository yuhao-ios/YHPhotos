//
//  PhotosShowCell.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void (^PhotosShowCellBlock)(UIImage *image);

@interface PhotosShowCell : UICollectionViewCell
/**选择按钮*/
@property(nonatomic,strong)UIButton *selectBTn;

//获取点击的那个图片blcok
@property(nonatomic,copy)PhotosShowCellBlock cellBlock;

//设置数据
-(void)setPhotoForPHAsset:(PHAsset *)set;

@end
