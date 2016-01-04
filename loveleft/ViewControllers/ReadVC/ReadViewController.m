//
//  ReadViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ReadViewController.h"
#import "ArticleViewController.h"
#import "RecordViewController.h"


@interface ReadViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UISegmentedControl *_segmentControl;
}
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self settingNav];
    [self createUI];
}

-(void)createUI
{
    // 创建scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    _scrollView.delegate = self;
    
    // 设置分页
    _scrollView.pagingEnabled = YES;
    
    // 隐藏指示条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置contentSize
    _scrollView.contentSize = CGSizeMake(SCREEN_W * 2, 0);
    
    // 实例化
    ArticleViewController * artVC = [[ArticleViewController alloc]init];
    RecordViewController * recordVC = [[RecordViewController alloc]init];
    
    NSArray * controllerArray = @[artVC,recordVC];
    
    // 滚动式的框架实现
    int i = 0;
    for(UIViewController * vc in controllerArray){
        
        vc.view.frame = CGRectMake(i * SCREEN_W, 0, SCREEN_W, SCREEN_H);
        [self addChildViewController:vc];
        [_scrollView addSubview:vc.view];
        i ++;
    }
    
    [self.view addSubview:_scrollView];
}


-(void)settingNav
{
    // 创建segment
    _segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    //  插入标题
    [_segmentControl insertSegmentWithTitle:@"读美文" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"看语录" atIndex:1 animated:YES];
   
    _segmentControl.tintColor = RGB(230, 20, 20, 1);
    _segmentControl.backgroundColor = [UIColor whiteColor];
    
    
    // 设置默认选中读美文
    _segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segmentControl;
    
    [_segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segmentControl;
    

}

#pragma mark - 响应方法

-(void)change:(UISegmentedControl * )segment
{
    if(segment.selectedSegmentIndex == 1)
    {
        _scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    }
                                     else{
                                         _scrollView.contentOffset = CGPointMake(SCREEN_W * 0, 0);
                                     }
}

// scrollView滑动时的关联方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x/SCREEN_W;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
