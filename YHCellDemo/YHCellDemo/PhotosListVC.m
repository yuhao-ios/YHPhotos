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
#import "PhotoShowVC.h"
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
    
    [cell getImageForAssetCollection:self.photoList[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    PhotoShowVC *vc = [[PhotoShowVC alloc]init];
    
    vc.coll = self.photoList[indexPath.row];
    
    vc.block = ^(NSMutableArray *imageArray){
    
        
        if (self.block) {
            [self.navigationController  popToRootViewControllerAnimated:YES];
            self.block(imageArray);
        }
    
    };
    
    
    [self.navigationController pushViewController:vc animated:YES];

}



@end
