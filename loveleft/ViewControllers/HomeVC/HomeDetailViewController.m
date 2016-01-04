//
//  HomeDetailViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIImageView * _headerView;
    UILabel * _headerLabel;
}

// 头视图的数据
@property (nonatomic, strong)NSMutableDictionary * dataDic;
// tableview的数据
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNav];
    // 顺序
    [self createUI];
    
    [self requestData];
}

-(void)requestData
{
    _dataDic = [[NSMutableDictionary alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    
    // 2.0 版本
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:HOMEDETAIL,[_dataID intValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 头部视图的数据
        _dataDic = responseObject[@"data"];
        
        // tableView 的数据
        _dataArray = _dataDic[@"product"];
        
        // 刷新
        [self reloadHeader];
        [_tableView reloadData]; //自带刷新方法
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)reloadHeader
{
    [_headerView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
    _headerLabel.text = self.dataDic[@"title"];
}


-(void)createUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    // 头部控件
    _headerView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_H, SCREEN_W / 3) imageName:nil];
    _headerLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, _headerView.frame.size.height - 40, SCREEN_W, 40) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:10]];
    
    [_headerView addSubview:_headerLabel];

}

#warning 图片没加！！
-(void)settingNav
{
    self.titleLabel.text = @"详情";
    
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    
    [self setLeftButtonClick:@selector(leftButtonClick)];
    
//    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
//    [self setRightButtonClick:@selector(rightButtonClick)];
    
}


#pragma mark - 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArray = self.dataArray[section][@"pic"];
    return sectionArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
        
        UIImageView * view = [FactoryUI createImageViewWithFrame:CGRectMake(10, 10, SCREEN_W - 20, 200) imageName:nil];
        view.tag = 99;
        [cell.contentView addSubview:view];
        
    }

    // 赋值
    UIImageView * imageView = [cell.contentView viewWithTag:99];
    
    if(self.dataArray){
        NSArray * sectionArray = self.dataArray[indexPath.section][@"pic"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:sectionArray[indexPath.row][@"pic"]]];
    }
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel * indexLabl = [FactoryUI createLabelWithFrame:CGRectMake(10, 10, 40, 40) text:[NSString stringWithFormat:@"%ld",section + 1] textColor:RGB(255, 156, 187, 1) font:[UIFont systemFontOfSize:15]];
    
    indexLabl.layer.borderColor = RGB(255, 156, 187, 1) .CGColor;
    indexLabl.layer.borderWidth = 2;
    
    [bgView addSubview:indexLabl];
    
    //  标题
    UILabel * titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(indexLabl.frame.size.width + indexLabl.frame.origin.x, 10, SCREEN_W - CGRectGetMaxX(indexLabl.frame), 40) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:15]];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.dataArray[section][@"title"];
    [bgView addSubview:titleLabel];
    
    // 价钱
    UIButton * priceButton = [FactoryUI createButtonWithFrame:CGRectMake(SCREEN_W - 80, 10, 70, 40) title:nil titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(priceButtonClick)];
    
    [priceButton setTitle:[NSString stringWithFormat:@"¥%@",self.dataArray[section][@"price"]] forState:UIControlStateNormal];
    [bgView addSubview:priceButton];
    
    return bgView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


#warning button点击事件未实现
-(void)priceButtonClick
{
    
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
