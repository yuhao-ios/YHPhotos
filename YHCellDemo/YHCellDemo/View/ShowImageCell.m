//
//  ShowImageCell.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "ShowImageCell.h"
#import <Masonry.h>
@implementation ShowImageCell


-(instancetype)initWithFrame:(CGRect)frame {

    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self layOutUI];
    }
    
    return self;

}
-(void)layOutUI {
    
    self.photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoView];
    self.title = [[UILabel alloc]init];
    self.title.textColor = [UIColor whiteColor];
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textAlignment = NSTextAlignmentCenter ;
    [self.contentView addSubview:self.title];
    
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.photoView.mas_bottom).offset(-10);
        make.width.equalTo(self.photoView);
        make.height.mas_equalTo(21);
    }];
    
    
}


-(void)setTileAndImage:(UIImage *)image indexPathForRow:(NSInteger)row allCount:(NSInteger)count{


    self.photoView.image= image;
    self.title.text = [NSString stringWithFormat:@"%ld/%ld",row+1,(long)count];
    
}

@end
