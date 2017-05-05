//
//  ViewController.m
//  YHCellDemo
//
//  Created by t4 on 17/5/4.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "YHPhotosData.h"
#import "PhotosListVC.h"
#define CellMargin  10
#define MainWidth  [UIScreen mainScreen].bounds.size.width
#define MainHeight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoCellDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray  *imageArray;
@property(nonatomic,strong)UIImagePickerController  *picController;

@end

@implementation ViewController

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
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
}
#pragma mark - 懒加载
-(UIImagePickerController *)picController{
    
    if (_picController == nil) {
        _picController = [[UIImagePickerController alloc]init];
        _picController.delegate = self;
        
    }
    return _picController;
}

-(NSMutableArray *)imageArray{
    
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


#pragma mark  - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{


    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imageArray.count +1 ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate =self;

    if (indexPath.row == self.imageArray.count) {
        
        cell.photoView.image = [UIImage imageNamed:@"plus.png"];
        cell.deleteBTn.hidden = YES;
        
    }else{
        
        
       cell.photoView.image = self.imageArray[indexPath.row];
        
        cell.deleteBTn.hidden = NO;
    }
    
    return cell;


}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.imageArray.count == indexPath.row) {
        
        [self alertViewForPhoto];
       
    }

}


#pragma mark  - 弹出选择框
-(void)alertViewForPhoto{

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self openCamera];
    }];
    
    UIAlertAction *actionForPhotos = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotos];
    }];
  
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [controller addAction:actionCamera];
    [controller addAction:actionForPhotos];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - ACTION;
//拍照
-(void)openCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }

    [self presentViewController:self.picController animated:YES completion:nil];
    
    
    
    

}
//打开相册
-(void)openPhotos{

   /* 
    打开系统定义的相册
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.picController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
  NSMutableArray *array =  [YHPhotosData getAllPhotoListData];
    NSLog(@"%@",array);
  [self presentViewController:self.picController animated:YES completion:nil];
    
  */
    
    //打开自己定义的相册
    PhotosListVC *vc = [[PhotosListVC alloc]init];
    vc.block = ^(NSMutableArray *imageArray){
        
        NSLog(@"%@",imageArray);
        [self.imageArray addObjectsFromArray:imageArray];
       [self.collectionView reloadData];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UIImagePickerControllerDelegate
//拍照/选择照片完成后的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"%@",info);
    UIImage *image ;
        //判断是否允许编辑
    if ([picker allowsEditing]) {
        
        image = info[UIImagePickerControllerEditedImage];
    }else {
        // 照片的元数据参数
        image = info [UIImagePickerControllerOriginalImage];
    }
    //将获取的照片添加到数组中
    [self.imageArray addObject:image];
    //返回上个界面刷新collectionView
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];

}


#pragma mark - PhotoCellDelegate
-(void)deleteThePhotoForCell:(PhotoCell *)cell deleteBtn:(UIButton *)btn{
    
    //找到cell对应得下标
    NSIndexPath *indexpath = [self.collectionView indexPathForCell:cell];
    
    [self.imageArray removeObjectAtIndex:indexpath.row];
    
    [self.collectionView reloadData];
    
}
@end
