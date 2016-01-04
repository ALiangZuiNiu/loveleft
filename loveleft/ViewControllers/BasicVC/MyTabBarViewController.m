//
//  MyTabBarViewController.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "FoodViewController.h"
#import "MusicViewController.h"
#import "MyViewController.h"
@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViewControllers];
    [self createTabBarItem];
}
-(void)createViewControllers{
    //实例化子页面
    HomeViewController * homeVC = [[HomeViewController alloc]init];
    UINavigationController * homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    ReadViewController * readVC = [[ReadViewController alloc]init];
    UINavigationController * readNav = [[UINavigationController alloc]initWithRootViewController:readVC];
    
    FoodViewController * foodVC = [[FoodViewController alloc]init];
    UINavigationController * foodNav = [[UINavigationController alloc]initWithRootViewController:foodVC];
    
    MusicViewController * musicVC = [[MusicViewController alloc]init];
    UINavigationController * musicNav = [[UINavigationController alloc]initWithRootViewController:musicVC];
    
    MyViewController * myVC =[[ MyViewController alloc]init];
    UINavigationController * myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    
    self.viewControllers = @[homeNav,readNav,foodNav,musicNav,myNav];
}


-(void)createTabBarItem{

    NSArray * unselectedImageArray = @[@"ic_tab_home_normal@2x",@"ic_tab_category_normal@2x",@"iconfont-iconfontmeishi",@"ic_tab_select_normal@2x",@"ic_tab_profile_normal_female@2x"];
    
    NSArray * selectedImageArray = @[@"ic_tab_home_selected@2x",@"ic_tab_category_selected@2x",@"iconfont-iconfontmeishi-2",@"ic_tab_select_selected@2x",@"ic_tab_profile_selected_female@2x"];
    
    NSArray * titleArray = @[@"首页",@"阅读",@"美食",@"音乐",@"我的"];

    for (int i=0; i<self.tabBar.items.count; i++) {
        UIImage * unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage * selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UITabBarItem * item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];





}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
