//
//  PhotosAnimation.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PhotosAnimationTypePresent = 0,
    PhotosAnimationTypeDismiss,
  } PhotosAnimationType;

@interface PhotosAnimation : NSObject<UIViewControllerAnimatedTransitioning>

///动画类型
@property(nonatomic,assign)PhotosAnimationType  type;


@end
