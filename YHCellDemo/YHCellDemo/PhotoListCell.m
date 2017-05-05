//
//  PhotoListCell.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotoListCell.h"
#import <Masonry.h>
#import "YHPhotosData.h"

@interface PhotoListCell ()

/**图片视图*/
@property(nonatomic,strong)UIImageView *photoView;
/**标题*/
@property(nonatomic,strong)UILabel *title;


@end

@implementation PhotoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setLayout];
    }

    return self;

}


-(void)setLayout {

    self.photoView = [[UIImageView alloc]init];
   
    [self.contentView addSubview:self.photoView];
    
    self.title = [[UILabel alloc]init];
    self.title.textAlignment = NSTextAlignmentLeft;

    [self addSubview:self.title];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(self.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photoView.mas_right).offset(10);
        make.top.equalTo(self.photoView.mas_top);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(self.photoView);
    }];
    
}




///设置数据
-(void)getImageForAssetCollection:(PHAssetCollection *)coll{
    
    PHAsset *set = [[YHPhotosData getPhotosForPHAssetCollection:coll] lastObject] ;
                    
    [[PHImageManager defaultManager]requestImageForAsset:set targetSize:self.photoView.frame.size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result == nil) {
            self.photoView.image = [UIImage imageNamed:@"no_data"];
        }else {
            
            self.photoView.image = result;
        }
    }];
   
     self.title.text = coll.localizedTitle;
}
@end
