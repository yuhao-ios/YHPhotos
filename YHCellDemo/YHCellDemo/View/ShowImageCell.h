//
//  ShowImageCell.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageCell : UICollectionViewCell

/**图片视图*/
@property(nonatomic,strong)UIImageView *photoView;
/**标题*/
@property(nonatomic,strong)UILabel *title;


-(void)setTileAndImage:(UIImage *)image indexPathForRow:(NSInteger) row allCount:(NSInteger)count;
@end
