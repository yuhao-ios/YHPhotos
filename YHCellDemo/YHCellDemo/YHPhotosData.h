//
//  YHPhotosData.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>//系统照片的框架
@interface YHPhotosData : NSObject

//获取所有的相册集
+(NSMutableArray *)getAllPhotoListData;

//获取某一个相册的所有资源
+(NSMutableArray *)getPhotosForPHAssetCollection:(PHAssetCollection *)collection;

//从相册的某一个照片资源获取一张高清照片
-(void)getImageObject:(id)set Complection:(void(^)(UIImage *photo,BOOL isDegraded))complection;

@end
