//
//  PreviewVC.h
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PreViewVCDelegate <NSObject>

-(void)dismissController:(UIViewController *)vc;

@end

@interface PreviewVC : UIViewController

@property(nonatomic,strong)NSArray * imageArray;

@property(nonatomic,weak)id <PreViewVCDelegate>  delegate;
@end
