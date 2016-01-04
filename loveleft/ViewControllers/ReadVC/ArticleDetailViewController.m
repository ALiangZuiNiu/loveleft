//
//  ArticleDetailViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleDetailViewController.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self settingNav];
    [self createUI];
}

-(void)createUI
{
    // 3.
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL,_artModel.dataID]]]];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:ARTICALDETAILURL, _artModel.dataID]]]];
    
    [self.view addSubview:web];
    
    web.scalesPageToFit = YES;
    [self.view addSubview:web];
    
    // webView 与js的交互
}


-(void)settingNav
{
    self.titleLabel.text = @"详情";
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setLeftButtonClick:@selector(leftClick)];
    
    [self.rightButton setImage:[UIImage imageNamed:@"iconfont-fenxiang"] forState:UIControlStateNormal];
    [self setRightButtonClick:@selector(rightClick)];
    
}


-(void)rightClick{
    
    // 下载网络图片
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.artModel.pic]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:APPKEY shareText:[NSString stringWithFormat:ARTICALDETAILURL,self.artModel] shareImage:image shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
}


-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 设置cell的动画效果为3D
    
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
