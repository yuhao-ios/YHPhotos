//
//  PhotosListVC.m
//  YHCellDemo
//
//  Created by t4 on 17/5/5.
//  Copyright © 2017年 t4. All rights reserved.
//

#import "PhotosListVC.h"
#import <Photos/Photos.h>
#import "PhotoListCell.h"
#import "YHPhotosData.h"
@interface PhotosListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *photoList;
@end

@implementation PhotosListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - 懒加载

-(NSMutableArray *)photoList{

    if (_photoList == nil) {
        _photoList = [NSMutableArray array];
        _photoList = [YHPhotosData getAllPhotoListData];
    }
    return _photoList;
}

///返回每一个相册最后一张照片资源
-(PHAsset *)getImageForIndexPathRow:(NSInteger)row{

    PHAssetCollection *collection  = self.photoList[row];
    
    PHAsset *set = [[YHPhotosData getPhotosForPHAssetCollection:collection] lastObject];

    return set;
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.photoList.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    
    PhotoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[PhotoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
   [[PHImageManager defaultManager]requestImageForAsset:[self getImageForIndexPathRow:indexPath.row] targetSize:CGSizeMake(80, 80) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
       if (result == nil) {
           cell.photoView.image = [UIImage imageNamed:@"no_data"];
       }else {
       
          cell.photoView.image = result;
       }
       
       PHAssetCollection *coll = self.photoList[indexPath.row];
       cell.title.text = coll.localizedTitle;
   }];
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

@end
