//
//  PhotosShowCell.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotosShowCell.h"
#import <Masonry.h>
@interface PhotosShowCell ()
/**图片视图*/
@property(nonatomic,strong)UIImageView *photoView;


@end


@implementation PhotosShowCell


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
       
        [self layOutUI];
    }
    return self;

}


-(void)layOutUI {

    self.photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoView];
    self.selectBTn = [[UIButton alloc]init];
    [self.selectBTn setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectBTn];
    
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.selectBTn mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.bottom.equalTo(self.photoView.mas_bottom);
        make.right.equalTo(self.photoView.mas_right);
        make.size.mas_equalTo(CGSizeMake(20, 20));
     
    }];
    

}


-(void)setPhotoForPHAsset:(PHAsset *)set{

    [[PHImageManager defaultManager]requestImageForAsset:set targetSize:self.photoView.frame.size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (result) {
            
            // 排除取消，错误，低清图三种情况，即已经获取到了高清图
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined) {
                
                self.photoView.image =result;
                
                if (self.cellBlock) {
                    self.cellBlock(result);
                }
            }
            
        }else {
            self.photoView.image = [UIImage imageNamed:@"no_data"];
        }
        
    }];

}


@end
