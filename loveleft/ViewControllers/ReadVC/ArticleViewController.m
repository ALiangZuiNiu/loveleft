//
//  ArticleViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleModel.h"
#import "ArticleTableViewCell.h"
#import "ArticleDetailViewController.h"

@interface ArticleViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
    int _page;
}

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
//    [self requestData];
    [self createRefresh];
}

-(void)createRefresh
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}

-(void)loadNewData
{
    _page = 0;
    _dataArray = [[NSMutableArray alloc]init];
    [self requestData];
}

-(void)loadMoreData
{
    _page ++;
    [self requestData];

}

-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

-(void)requestData
{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //  手动设置数据格式,默认支持JSON
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    
    [manager GET:[NSString stringWithFormat:ARTICALURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * array = responseObject[@"data"];
        
        for(NSDictionary * dict in array)
        {
            ArticleModel * model = [[ArticleModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
        }
        
        if (_page == 0) {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
            
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"%@",error);
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"artCell"];
    
    if(cell == nil)
    { 
        cell = [[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"artCell"];
    }
    
    ArticleModel * model = _dataArray[indexPath.row];
    [cell refreshUI:model];
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailViewController * VC = [[ArticleDetailViewController alloc]init];
    ArticleModel * model  = _dataArray[indexPath.row];
    VC.artModel = model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


//添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置动画效果为3D效果
    cell.layer.transform = CATransform3DMakeScale(0, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
