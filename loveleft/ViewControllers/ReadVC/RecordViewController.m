//
//  RecordViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordModel.h"
#import "RecordCell.h"

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    // 分页
    int _page;
    
    float Height;
}

@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self refreshUI];
}

#pragma mark -－创建tableView－
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)refreshUI
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_tableView.header beginRefreshing];
}

// 下拉刷新
-(void)loadNewData
{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self requestData];
}

//  上拉刷新
-(void)loadMoreData
{
    _page ++;
    [self requestData];
}


#pragma mark -数据请求－
-(void)requestData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:UTTERANCEURL,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for(NSDictionary * dict in responseObject[@"content"]){
        
        RecordModel * model = [[RecordModel alloc]init];
        
            model.textString = dict[@"text"];
            model.pub_timeString = dict[@"pub_time"];
            model.image_url = dict[@"image_urls"][0][@"middle"];
            model.publisher_icon_urlString = dict[@"publisher_icon_url"];
            model.dataID = dict[@"id"];
            model.publisher_nameString = dict[@"publisher_name"];
            
            [self.dataArray addObject:model];
        }
        
        if(_page == 0){
            [_tableView.header endRefreshing];
        }else{
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark -tableView的代理方法－
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RecordID"];
    if(cell == nil)
    {
        cell = [[RecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RecordID"];
    }
    if(self.dataArray){
        RecordModel * model = self.dataArray[indexPath.row];
        [cell refreshUI:model];
        Height = cell.cellHeight;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Height;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
