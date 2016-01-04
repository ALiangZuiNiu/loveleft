//
//  AppDelegate.m
//  loveleft
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "GuidePageView.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"

@interface AppDelegate ()

@property (nonatomic,strong) MyTabBarViewController * myTabBar;
@property (nonatomic,strong) GuidePageView * guideView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 实例化
    LeftViewController * leftVC = [[LeftViewController alloc]init];
    self.myTabBar= [[MyTabBarViewController alloc]init];
    
    MMDrawerController * drawVC = [[MMDrawerController alloc]initWithCenterViewController:self.myTabBar leftDrawerViewController:leftVC];
    
    // 设置抽屉打开雨关闭的模式
    drawVC .openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    // 设置打开后的宽度
    drawVC.maximumLeftDrawerWidth = SCREEN_W - 100;
    
    self.window.rootViewController = drawVC;
    
//    self.myTabBar= [[MyTabBarViewController alloc]init];
//    self.window.rootViewController = self.myTabBar;
    
    //  改变状态栏的颜色  结合修改plist文件
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent; // 白色
    
    //添加引导页
    [self createGuidePage];

    [self addUMShare];
    
    [self.window makeKeyAndVisible];

    return YES;
}

-(void)addUMShare
{
    // 注册友盟分享
    [UMSocialData setAppKey:APPKEY];
    
    // 注册qq的AppID，appkey与url
    //  nil代表 分享成功时提示的内容是来自 “友盟社会化组件”
    [UMSocialQQHandler setQQWithAppId:@"991468879" appKey:@"MnGtpPN5AiB6MNvjni" url:nil];

    // 设置微信
    [UMSocialWechatHandler setWXAppId:@"wx12b249bcbf753e87" appSecret:@"0a9cd00c48ee47a9b23119086bcd3b30" url:nil];
    
    // 打开微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    
//    隐藏未安装的平台
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
}


-(void) createGuidePage{

    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRund"]boolValue]) {
        NSArray * imageArray = @[@"welcome6",@"welcome7",@"welcome4"];
        self.guideView  =  [[GuidePageView alloc]initWithFrame:self.window.bounds ImageArray:imageArray];
        [self.myTabBar.view addSubview:self.guideView];
        
        //第一次运行完后记录
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:@"isRund"];
        
    }
    [self.guideView.GoInButton addTarget:self action:@selector(goinButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)goinButtonClick{


    [self.guideView removeFromSuperview];


}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
