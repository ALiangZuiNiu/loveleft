//
//  MusicDetailViewController.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MBProgressHUD.h"
#import "MusicModel.h"
#import "MusicListCell.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    int _page;
}

@property(nonatomic, strong) NSMutableArray * dataArray;
@property(nonatomic, strong) MBProgressHUD * hud;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _page = 0;
    self.dataArray = [[NSMutableArray alloc]init];
    
    //  进入页面即显示数据
    [self requestData];
    [self settingNav];
    [self createTableView];
    [self refreshUI];
}


-(void)refreshUI
{
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// 上啦加载
-(void)loadMoreData
{
    _page ++;
    [self requestData];
}

-(void)requestData
{
    [self.hud show:YES];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for(NSDictionary * dict in responseObject[@"data"]){
            MusicModel * model = [[MusicModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
        }
        [_tableView.footer endRefreshing];
        [self.hud hide:YES];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    self.hud.labelText = @"加载中。。。。。。";
    
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    
    self.hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2]; // 灰色
    // 设置中间指示器的颜色
    self.hud.activityIndicatorColor = [UIColor whiteColor];
    
    [self.view addSubview:self.hud];
}

#pragma mark - 代理方法-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if(self.dataArray){
        
        MusicModel * model = self.dataArray[indexPath.row];
        
    }

        return cell;
}



-(void)settingNav
{
    self.titleLabel.text = self.typeString;
    [self.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
}

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
