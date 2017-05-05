//
//  PhotoCell.m
//  YHCellDemo
//
//  Created by t4 on 17/5/4.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotoCell.h"
#import <Masonry.h>

@interface PhotoCell ()



@end

@implementation PhotoCell


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    
    if (self) {
        
        [self layOutForCell];
    }



    return self;
}


//布局
-(void)layOutForCell {

  self.photoView = [[UIImageView alloc]init];
  self.deleteBTn= [[UIButton alloc]init];
  [self.deleteBTn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.contentView addSubview:self.photoView];
  [self.contentView addSubview:self.deleteBTn];
  [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
     /* make.top.equalTo(self.mas_top).offset(5);
      make.right.equalTo(self.mas_right).offset(-5);
      make.left.equalTo(self.mas_left).offset(5);
      make.bottom.equalTo(self.mas_bottom).offset(-5);*/
      make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
  }];
 
    
  [self.deleteBTn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.mas_top).offset(0);
      make.right.equalTo(self.mas_right).offset(0);
      make.size.mas_equalTo(CGSizeMake(20, 20));
  }];
    ;
    [self.deleteBTn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];

}

//删除按钮点击方式
-(void)deleteBtnAction:(UIButton *)sender{

    if ([self.delegate respondsToSelector:@selector(deleteThePhotoForCell:deleteBtn:)]) {
        [self.delegate deleteThePhotoForCell:self deleteBtn:sender];
    }


}








@end
