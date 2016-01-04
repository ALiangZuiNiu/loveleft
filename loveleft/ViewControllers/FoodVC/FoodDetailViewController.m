//
//  FoodDetailViewController.m
//  loveleft
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodDetailCell.h"
#import "PlayerViewController.h"
#import "FoodStepTableViewCell.h"

@interface FoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    //页数
    int _page;
    //头试图
    UIView *_bgView;
}

//总的数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
//步骤的数据源
@property (nonatomic,strong) NSMutableArray *stepArray;
//展示数据源
@property (nonatomic,strong) NSMutableArray *showArray;

@end

@implementation FoodDetailViewController

#pragma mark -页面将要发生时隐藏导航
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

//页面将要销毁时显示导航
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

-(void)dealloc
{
    _tableView.delegate = nil;
}

//当tableView滑到一个屏幕的高度时,显示导航
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        
        if (_tableView.contentOffset.y > SCREEN_H) {
            
            self.navigationController.navigationBarHidden = NO;
        }else{
            self.navigationController.navigationBarHidden = YES;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    [self createTableView];
    [self refreshUI];
}

-(void)createNav
{
    self.titleLabel.text = _foodName;
    [self.leftButton setImage:[UIImage imageNamed:@"qrcode_scan_titlebar_back_nor@2x.png"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftButtonClick)];
}

- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W   , SCREEN_H) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = RGB(255, 156, 187, 1);
    [self.view addSubview:_tableView];
}

-(void)refreshUI
{
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //页面出现时就刷新一次
    [_tableView.header beginRefreshing];
}

// 下拉刷新
-(void)loadNewData
{
    _page = 0;
    self.stepArray = [NSMutableArray arrayWithCapacity:0];
    self.showArray = [NSMutableArray arrayWithCapacity:0];
    [self requestData];
}

-(void)requestData
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    NSDictionary * dic = @{@"dishes_id": _dishID, @"methodName": @"DishesView"};
    
    [manage POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 0) {
            
            NSLog(@"======%@",responseObject);
            
            FoodDetailModel *model = [[FoodDetailModel alloc] init];
            
            model.image = responseObject[@"data"][@"image"];
            model.material_desc = responseObject[@"data"][@"material_desc"];
            model.dishes_id = responseObject[@"data"][@"dishes_id"];
            model.dishes_name = responseObject[@"data"][@"dashes_name"];
            //材料
            model.material_video = responseObject[@"data"][@"material_video"];
            model.process_video = responseObject[@"data"][@"process_video"];
            
            [self.showArray addObject:model];
            
            for (NSDictionary *dict in responseObject[@"data"][@"step"]) {
                
                FoodStepModel *stepModel = [[FoodStepModel alloc] init];
                
                stepModel.dishes_step_descString = dict[@"dishes_step_desc"];
                stepModel.dishes_step_imageString = dict[@"dishes_step_image"];
                
                [self.stepArray addObject:stepModel];
            }
        }
        
        if(_page == 0)
        {
            [_tableView.header endRefreshing];
        }
        [_tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark --tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.showArray.count;
        
    }else{
        
        return self.stepArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        FoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodDetailID"];
        if (cell == nil) {
            cell = [[FoodDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"foodDetailID"];
        }
        
        FoodDetailModel *model = self.showArray[indexPath.row];
        [cell refreshUI:model];
        
        //返回
        cell.myFanHuiBlock = ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        };
        
        //播放食物制作步骤
        cell.playBlock = ^(FoodDetailModel *fmodel){
            
            PlayerViewController *play = [[PlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model.process_video]];
            //准备播放
            [play.moviePlayer prepareToPlay];
            //开始播放
            [play.moviePlayer play];
            [self presentViewController:play animated:YES completion:nil];
            
        };
        
        //播放食材准备
        cell.playFoodMeBlock = ^(FoodDetailModel *fmModel){
            
            PlayerViewController *play = [[PlayerViewController alloc] initWithContentURL:[NSURL URLWithString:model.material_video]];
            //准备播放
            [play.moviePlayer prepareToPlay];
            //开始播放
            [play.moviePlayer play];
            [self presentViewController:play animated:YES completion:nil];
        };
        
        return cell;
        
    }else{
        
        FoodStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foodStepID"];
        if (cell == nil) {
            cell = [[FoodStepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"foodStepID"];
        }
        
        if (self.stepArray) {
            FoodStepModel *model = self.stepArray[indexPath.row];
            [cell refreshUI:model IndexPath:indexPath];
        }
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 530;
    }else{
        return 190;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self createHeadView];
    return _bgView;
    
}

- (void)createHeadView
{
    
    _bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    [self.view addSubview:_bgView];
    
    UILabel *stepLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, SCREEN_W, 38) text:@"制作步骤" textColor:nil font:[UIFont systemFontOfSize:18]];
    stepLabel.backgroundColor = [UIColor lightGrayColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:stepLabel];
    
    UIView *lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, SCREEN_W, 2)];
    lineView.backgroundColor = RGB(255, 156, 187, 1);
    [_bgView addSubview:lineView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 40;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
