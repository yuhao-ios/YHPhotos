//
//  YHPhotosData.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "YHPhotosData.h"

@implementation YHPhotosData

/*
 
 PHAsset:代表照片库的一个资源  也就是具体的某一个照片或者视频
 
 PHFetchOptions: 获取资源的参数 可以为nil
 
 PHFetchResult:表示一系列的资源结果集合，也可以是相册的集合 从PHCollection方法中获得
 
 PHAssetCollection: PHCollection的子类，表示一个相册或者一个时刻（最近删除、收藏）
 
 PHImageManager:用于处理资源的加载，加载图片的过程有缓存，可以使用PHImageRequestOptions 控制资源的输出尺寸等规格
 
 PHCollectionList:表示一组PHCollection
 */




+(NSMutableArray *)getAllPhotoListData{

    NSMutableArray *dataArray = [NSMutableArray array];
    //1.0列出所有智能相册
    PHFetchResult *samrtResult  = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"%@ %lu",samrtResult,(unsigned long)samrtResult.count);
    
    for(int i = 0 ;i<samrtResult.count; i++) {
    
        [dataArray addObject:samrtResult[i]];
    }
   //2.0列出所有的用户创建的相册
    PHFetchResult *userResult = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (PHAssetCollection *sub  in userResult) {
    
        [dataArray addObject:sub];
    }
    
    return dataArray;
}



+(NSMutableArray *)getPhotosForPHAssetCollection:(PHAssetCollection *)collection{

    NSMutableArray *photosArray = [NSMutableArray array];
    //1.获取了结果集
    PHFetchResult *photosResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    
    //2.便利结果集 取出具体某一张图片资源  添加在数组中
    
    for(PHAsset *set  in  photosResult){
    
        if(set.mediaSubtypes == PHAssetMediaSubtypeNone){
        
            [photosArray addObject:set];
        }
    
    }
    return  photosArray;

}

-(void)getImageObject:(id)set Complection:(void (^)(UIImage *, BOOL))complection
{
    if ([set isEqual:[PHAsset class]]){
        
        PHAsset *photoSet = set;
        CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;

       //1.0算出照片资源自身的比例
        CGFloat setScale = photoSet.pixelWidth/photoSet.pixelHeight;
        //1.1 获取屏幕比例
        //屏幕分辨率 scale = 1 代表 分辨率是320 * 480; =2 代表 分辨率是 640 * 960; = 3 代表 分辨率是 1242 * 2208
        CGFloat scale = [UIScreen mainScreen].scale;
        
        //1.2计算照片在不同屏幕上的像素
        
        CGFloat pixWidth = mainWidth * scale;
     
        //1.3根据图片自身比例计算照片在屏幕上的高
        CGFloat pixheight = mainWidth/setScale;
        
        /**
         *  PHImageManager 是通过请求的方式拉取图像，并可以控制请求得到的图像的尺寸、剪裁方式、质量，缓存以及请求本身的管理（发出请求、取消请求）等
         *
         *  @param pixelWidth 获取图片的宽
         *  @param pixelHeight 获取图片的高
         *  @param contentMode 图片的剪裁方式
         *
         *  @return
         */
    
     [[PHImageManager defaultManager] requestImageForAsset:photoSet targetSize:CGSizeMake(pixWidth, pixheight) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         // 排除取消，错误，低清图三种情况，即已经获取到了高清图
         BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
         if (downloadFinined) {
             //回调
             if (complection){
                 
                 complection(result,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
             }
         }

     }];
    
   
 }




}
@end
