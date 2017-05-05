//
//  PhotosAnimation.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotosAnimation.h"

@implementation PhotosAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return 1.5;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    if (self.type == PhotosAnimationTypePresent) {
        
        [self presentControllerWithTransition:transitionContext];
    }else{
    
        [self dismissControllerWithTransition:transitionContext];
    }


}

//弹出
-(void)presentControllerWithTransition:(id<UIViewControllerContextTransitioning>)transitionContext{

    UIView *fatherView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//来源控制器
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//目标控制器
    [fatherView addSubview:toVC.view];
    
    
     [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
         fromVC.view.alpha = 0;
         toVC.view.alpha = 1;
         
     } completion:^(BOOL finished) {
         
         BOOL wasCancelled = [transitionContext transitionWasCancelled];
         
         [transitionContext completeTransition:!wasCancelled];
     }];
   

}
//消失
-(void)dismissControllerWithTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *fatherView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//来源控制器
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//目标控制器
    [fatherView addSubview:toVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
        
        
    } completion:^(BOOL finished) {

        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        [transitionContext completeTransition:!wasCancelled];
    }];
    

    
    
}

@end
