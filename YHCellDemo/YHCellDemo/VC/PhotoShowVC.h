//
//  PhotoShowVC.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void (^PhotoShowVCBlock)(NSMutableArray *imageArray);

@interface PhotoShowVC : UIViewController

//某一具体相册
@property(nonatomic,strong)PHAssetCollection * coll;

// 生成一个 block 属性
@property(nonatomic, copy) PhotoShowVCBlock block;

@end
