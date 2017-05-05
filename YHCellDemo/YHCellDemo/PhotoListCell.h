//
//  PhotoListCell.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface PhotoListCell : UITableViewCell



//设置数据
-(void)getImageForAssetCollection:(PHAssetCollection *)coll;

@end
