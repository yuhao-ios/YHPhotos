//
//  PhotoShowVC.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotoShowVC.h"
#import "PhotosShowCell.h"
#import "YHPhotosData.h"
#import "PreviewVC.h"
#define CellMargin  10
#define MainWidth  [UIScreen mainScreen].bounds.size.width
#define MainHeight  [UIScreen mainScreen].bounds.size.height
@interface PhotoShowVC ()<UICollectionViewDelegate,UICollectionViewDataSource,PreViewVCDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray  *imageArray;
@property(nonatomic,strong)NSMutableArray  *selectImageArray;
@end

@implementation PhotoShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
  

    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake((MainWidth-5*CellMargin)/4, (MainWidth-5*CellMargin)/4);
    
    NSLog(@"%f",(MainWidth-5*CellMargin)/4);
    layout.minimumLineSpacing = CellMargin;
    layout.minimumInteritemSpacing = CellMargin;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, MainWidth, MainHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[PhotosShowCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(MainWidth-64, 10, 44, 44)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    UIButton *lookBtn = [[UIButton alloc]initWithFrame:CGRectMake(MainWidth-64, MainHeight-64, 44, 44)];
      [lookBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [lookBtn setTitle:@"预览" forState:UIControlStateNormal];
    [lookBtn addTarget:self action:@selector(clickLookBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lookBtn];
    
}


#pragma mark - ACTION
-(void)clickBtn:(UIButton *)sender{
    if (self.selectImageArray.count > 0) {
        if (self.block) {
            
            [self.navigationController popViewControllerAnimated:YES];
            self.block(self.selectImageArray);
        }

    }else {
    
        NSLog(@"还没选择图片");

    }

}

-(void)clickLookBtn:(UIButton *)btn{

    PreviewVC *vc = [[PreviewVC alloc]init];
    if (self.selectImageArray > 0) {
        vc.imageArray = self.selectImageArray;
    }else {
    
        NSLog(@"请先选中图片");
    
    }
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];

}



-(void)dismissController:(UIViewController *)vc{

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 懒加载
-(NSMutableArray *)imageArray{
    
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        
        _imageArray = [YHPhotosData getPhotosForPHAssetCollection:self.coll];
        
    }
    return _imageArray;
}
-(NSMutableArray *)selectImageArray{

    if (_selectImageArray == nil) {
        _selectImageArray = [NSMutableArray array];
    }


    return _selectImageArray;
}

#pragma mark  - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count  ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PhotosShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setPhotoForPHAsset:self.imageArray[indexPath.row]];
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotosShowCell *cell  = (PhotosShowCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.selectBTn.selected) {
        cell.selectBTn.selected = NO;
        
        [cell.selectBTn setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        [self.selectImageArray removeObjectAtIndex:indexPath.row];
    }else {
        cell.selectBTn.selected = YES;
        [cell.selectBTn setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
        
        [cell setPhotoForPHAsset:self.imageArray[indexPath.row]];
        
         cell.cellBlock = ^(UIImage *image) {
        
         [self.selectImageArray addObject:image];
 
        };
       
    }
    

}





@end
