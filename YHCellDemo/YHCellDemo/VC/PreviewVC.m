//
//  PreviewVC.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PreviewVC.h"
#import "PhotosAnimation.h"
#import "ShowImageCell.h"
#define CellMargin  10
#define MainWidth  [UIScreen mainScreen].bounds.size.width
#define MainHeight  [UIScreen mainScreen].bounds.size.height
@interface PreviewVC ()<UIViewControllerTransitioningDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation PreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];;
    self.transitioningDelegate = self;
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(MainWidth-40,400) ;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth-40, 400) collectionViewLayout:layout];
    self.collectionView.center =self.view.center;
    self.collectionView.bounces = YES;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[ShowImageCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(clickbackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

#pragma mark - ACTION 

-(void)clickbackBtn:(UIButton *)btn {

    if ([self.delegate respondsToSelector:@selector(dismissController:)]) {
        [self.delegate dismissController:self];
    }
    

}


#pragma mark  - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count  ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ShowImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setTileAndImage:self.imageArray[indexPath.row] indexPathForRow:indexPath.row allCount:self.imageArray.count];
    return cell;
    
    
}






#pragma mark - UIViewControllerTransitioningDelegate



-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    PhotosAnimation *ani = [[PhotosAnimation alloc]init];
    ani.type = PhotosAnimationTypePresent;
    
    return  ani;

}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    PhotosAnimation *ani = [[PhotosAnimation alloc]init];
    ani.type = PhotosAnimationTypeDismiss;

    return  ani;

}
@end
