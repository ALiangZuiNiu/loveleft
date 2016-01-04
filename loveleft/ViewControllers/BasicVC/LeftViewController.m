//
//  LeftViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()


@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation LeftViewController

-(void)dealloc
{
    [self removeObserver:[NSUserDefaults standardUserDefaults] forKeyPath:@"isLogin" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(185, 82, 82, 1);
    
    [self createUI];
    
}

-(void)createUI
{
    UIImageView * photoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [photoView setImage:[UIImage imageNamed:@""]];
    photoView.center = CGPointMake(SCREEN_W / 2, SCREEN_H/3);
    
    //  内容和子视图省略视图的范围。默认是没有
    photoView.clipsToBounds = YES;
    
    photoView.layer.cornerRadius = 50;
    [self.view addSubview:photoView];
    
}

-(void)downMyInformation
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
