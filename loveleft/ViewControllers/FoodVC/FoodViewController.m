//
//  FoodViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodModel.h"
#import "FoodCell.h"
#import "FoodTitleCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerViewController.h"
#import "FoodDetailViewController.h"

#import <AVKit/AVKit.h>  /*avplaycontroller*/
#import <AVFoundation/AVFoundation.h> /*avplayer*/


@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout, playDelegate>

{

    // 分类id
    UICollectionView *_collectionView;
    //  分类
    NSString *_categoryID;
    //  标题
    NSString *_titleString;
    // 指示条
    UIView *_lineView;
    // 分页
    int _page;
}

// 数据源
@property (nonatomic,strong) NSMutableArray * dataArray;
// Button数组
@property (nonatomic,strong) NSMutableArray * buttonArray;

@end

@implementation FoodViewController



-(void)viewWillAppear:(BOOL)animated
{
    for(UIButton * btn in self.buttonArray)
    {
        if (btn == [self.buttonArray firstObject]) {
            btn.selected = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self settingNav];
    [self createHeaderView];
    [self createCollectionView];
    [self createRefresh];
    
}


#pragma mark --创建刷新请求数据

-(void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_collectionView.header beginRefreshing];
}

-(void)loadNewData
{
    _page = 0;
    self.dataArray = [[NSMutableArray alloc]init];
    [self requestData];
}

-(void)loadMoreData
{
    _page ++;
    [self requestData];
}

-(void)requestData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id":_categoryID, @"size": @"20"};
    
    [manager POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if([responseObject[@"code"]intValue] == 0){
            
            for(NSDictionary * dic in responseObject[@"data"][@"data"]){
                
                // 字典转模型
                FoodModel * model = [[FoodModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        // 结束刷新
        if(_page == 0)
        {
            [_collectionView.header endRefreshing];
        }else{
            [_collectionView.footer endRefreshing];
        }
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -- 创建collection

-(void)createCollectionView
{
    // 创建网格布局
    NBWaterFlowLayout * flowLayout = [[NBWaterFlowLayout alloc]init];
    
    // 网格的大小
    flowLayout.itemSize = CGSizeMake((SCREEN_W - 20)/2, 100);
    
    // 设置列数
    flowLayout.numberOfColumns = 2;
    
    // 设置代理
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H-40) collectionViewLayout:flowLayout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerClass:[FoodCell class] forCellWithReuseIdentifier:@"food"];
    
    [_collectionView registerClass:[FoodTitleCell class] forCellWithReuseIdentifier:@"title"];
    
}


#pragma mark -- 实现collectionView的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray ? self.dataArray.count+1 : 0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //标题
        FoodTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"title" forIndexPath:indexPath];
        //赋值
        cell.titleLabel.text = _titleString;
        return cell;
        
    }
    else{
        //正文
        FoodCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"food" forIndexPath:indexPath];
        
        //设置代理
        cell.delegate = self;
        
        //赋值
        //cell.backgroundColor = [UIColor redColor];
        
        if (self.dataArray) {
            FoodModel * model = self.dataArray[indexPath.row-1];
            [cell refreshUI:model];
        }
        
        return cell;
        
        
    }
    return 0;
    
}
//设置cell的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:
(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    }
    else{
        
        return 170;
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    FoodDetailViewController * foodDetail = [[FoodDetailViewController alloc]init];
    
    FoodModel * model = self.dataArray[indexPath.row - 1];
    foodDetail.dishID = model.dishes_id;
    foodDetail.foodName = model.title;
    [self.navigationController pushViewController:foodDetail animated:YES];
}

/*
#pragma mark -- 实现自定义的代理方法
-(void)play:(FoodModel *)model{
    
//    //进行视频播放
//    //MPMoviePlayerViewController * playerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
//    //强制横屏
//    PlayerViewController * playerVC = [[PlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
//    //设置播放界面
//    [playerVC.moviePlayer prepareToPlay];
//    
//    [playerVC.moviePlayer play];
//    
//    [self presentViewController:playerVC animated:YES completion:nil];
    
    
    AVPlayerViewController * playerVC = [[AVPlayerViewController alloc]init];
    AVPlayer * avPlayer = [AVPlayer playerWithURL: [NSURL URLWithString:model.video]];
    playerVC.player = avPlayer;
    [self presentViewController:playerVC animated:YES completion:nil];
}
*/

#pragma mark -- 初始化数据
-(void)initData{
    _categoryID = @"1";
    _titleString = @"家常菜";
    self.buttonArray = [[NSMutableArray alloc]init];
}

#pragma mark -- 设置导航
-(void)settingNav{
    self.titleLabel.text = @"美食";
}

#pragma mark -- 创建头部分类按钮
-(void)createHeaderView{
    
    NSArray * titleArray = @[@"家常菜",@"小炒",@"凉菜",@"烘培",];
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton * headerButton = [FactoryUI createButtonWithFrame:CGRectMake(i*SCREEN_W/4, 0, SCREEN_W/4, 40) title:titleArray[i] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButtonClick:)];
        //设置选中时候的颜色
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        headerButton.tag = 10+i;
        [bgView addSubview:headerButton];
        //将创建的Button添加进数组中
        [self.buttonArray addObject:headerButton];
    }
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_W/4, 2)];
    _lineView.backgroundColor =[UIColor redColor];
    [bgView addSubview:_lineView];
}


#pragma mark -- 按钮响应方法
-(void)headerButtonClick:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake((button.tag-10)*SCREEN_W/4, 38, SCREEN_W/4, 2);
    }];
    //保证让每次点击的时候只选中一个按钮
    for (UIButton * btu  in self.buttonArray) {
        if (btu.selected == YES) {
            btu.selected = NO;
        }
    }
    button.selected = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
