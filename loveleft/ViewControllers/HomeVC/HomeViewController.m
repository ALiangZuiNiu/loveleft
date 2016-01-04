//
//  HomeViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
// 类别
#import "UIViewController+MMDrawerController.h"

// 二维码扫描
#import "CustomViewController.h"

// 广告轮播
#import "Carousel.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"



@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    Carousel * _cyclePlayer;
    UITableView * _tableView;
    
    // 分页
    int _page;
}

@property(nonatomic, strong)NSMutableArray * dataArray;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNav];
    [self createHeaderView];
    [self createTableView];
    [self createRefresh];
}


#pragma mark - 刷新
-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //  当第一次启动时 自动刷新一次
    [_tableView.header beginRefreshing];
}


#pragma mark - 下拉刷新
-(void)loadNewData
{
    _page = 1;
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self requestData];
    
}

#pragma mark - 加载更多
-(void)loadMoreData
{
    _page ++;
    [self requestData];
}

#pragma mark - 请求数据
-(void)requestData
{
    AFHTTPRequestOperationManager * manager  =  [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for(NSDictionary * dic in responseObject[@"data"][@"entry_list"])
        {
            HomeModel * model = [[HomeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
            if(_page == 1)
            {
                [_tableView.header endRefreshing];
            }
            else
            {
                [_tableView.footer endRefreshing];
            }
            [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}




#pragma mark - 创建tableView      懒加载？
-(void)createTableView
{
    // 网络请求下来的图片   先请求下来数据在放入数组中
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    // 修改分割线 1.
    _tableView.separatorColor = [UIColor clearColor];
    
//    // 2.
//    _tableView.separatorStyle = UITableViewScrollPositionNone;
//    
//    // 3. 去掉多余的线条
//    _tableView.tableFooterView = [[UIView alloc]init];
    
    
    // 设置头视图
    _tableView.tableHeaderView = _cyclePlayer;
    
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if(!cell)
    {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    // 赋值
    if(self.dataArray){
        HomeModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailViewController * datail = [[HomeDetailViewController alloc]init];
    // 传值
    HomeModel * model = self.dataArray[indexPath.row];
    datail.dataID = model.dataID;
    
    datail.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:datail animated:YES];
}


// 广告轮播的两种思路
#pragma mark - 创建tabbleView的头视图 即 广告栏
-(void)createHeaderView
{
    _cyclePlayer = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3)];
    
    // 设置是否需要pageCotnroller
    _cyclePlayer.needPageControl = YES;
    
    // 设置是否需要无限轮播
    _cyclePlayer.infiniteLoop = YES;
    
    _cyclePlayer.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE;
    _cyclePlayer.imageArray = @[@"shili8",@"shili2",@"shili10",@"shili13"];
    
}


#pragma mark - 设置导航
-(void)settingNav
{
    self.titleLabel.text = @"爱生活";
    [self.leftButton setImage:[UIImage imageNamed:@"icon_function"] forState:UIControlStateNormal];

    [self.rightButton setImage:[UIImage imageNamed:@"2vm"] forState:UIControlStateNormal];
  
    // 设置相应事件
    [self setLeftButtonClick:@selector(leftButtonClick)];
    [self setRightButtonClick:@selector(rightButtonClick)];
    
}

#pragma mark - 响应事件
-(void)leftButtonClick
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

// 二维码扫描
-(void)rightButtonClick
{
    //     设置为NO 则能扫描二维码与条形码
    CustomViewController * VC = [[CustomViewController alloc]initWithIsQRCode:NO Block:^(NSString * result, BOOL isSuccess) {
     
        if(isSuccess)
        {
            NSLog(@"%@",result);
        }
    }];
    [self presentViewController:VC animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
