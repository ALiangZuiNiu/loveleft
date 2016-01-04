//
//  MusicViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MusicViewController.h"
#import "NBWaterFlowLayout.h"
#import "MusicCollectionViewCell.h"
#import "MusicCollectionReusableView.h"
#import "MusicDetailViewController.h"

@interface MusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout>

{
    UICollectionView *_collectionView;
}

@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * urlArray;
@property(nonatomic,strong)NSArray * imageArray;

@end

@implementation MusicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initArray];
    [self settingNav];
    [self createCollectionView];
//    [self createRefresh];
}

-(void)initArray
{
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
}

#pragma mark - 设置导航栏
-(void)settingNav
{
    self.titleLabel.text = @"音乐";
}

#pragma mark - 创建collectionView

-(void)createCollectionView
{
    //  创建网格布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //  设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    //  创建网格对象（collectionView）
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) collectionViewLayout:flowLayout];
    
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];

    //  注册cell类
    [_collectionView registerClass:[MusicCollectionViewCell class] forCellWithReuseIdentifier:@"music"];
    
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
    
    [_collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];
}


#pragma mark - 代理方法

//  确定collection的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//  确定section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"music" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}

//  设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_W-40)/2 , 150);
}

//  设置垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// 设置水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// 四周的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

// 设置header的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(180, 30);
}

// 设置footer的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

// 设置header和footer的view
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    
    if(kind == UICollectionElementKindSectionHeader)
    {
        view.titleLabel.text = @"我是脑袋";
    }
    else{
        view.titleLabel.text = @"我是尾巴";
    }
    return view;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    MusicDetailViewController * detail = [[MusicDetailViewController alloc]init];
//    detail.typeString = self.nameArray[indexPath.item];
//    detail.urlString = self.urlArray[indexPath.item];
//    
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
