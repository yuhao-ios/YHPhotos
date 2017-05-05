//
//  PhotosListVC.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhotoListBlock)(NSMutableArray *imageArray);

@interface PhotosListVC : UIViewController

// 生成一个 block 属性
@property(nonatomic, copy) PhotoListBlock block;

@end
