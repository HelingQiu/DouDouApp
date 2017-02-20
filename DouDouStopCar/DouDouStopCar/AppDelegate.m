//
//  AppDelegate.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/7.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "ViewController.h"
#import "DouDouLoginViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) RDVTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
//    [self setUpViewControllers];
    
    [self.window setRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"]];
    
    return YES;
}

- (void)setUpViewControllers{
    // Root view controller
    ViewController *homeViewController = [[ViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    
    
    ViewController *mineViewController = [[ViewController alloc] init];
    UINavigationController *minenav = [[UINavigationController alloc]initWithRootViewController:mineViewController];
    
    UINavigationController *memberNav = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MemberNavigationController"];
    
    
    self.tabBarController = [[RDVTabBarController alloc] init];
    
    /**
     * update by zhouyongbo 2016/01/19
     *
     * 加入分割线
     */
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 0.5)];
    lineV.backgroundColor = [UIColor grayColor];
    [self.tabBarController.tabBar addSubview:lineV];
    
    self.tabBarController.tabBar.translucent = YES;
    [self.tabBarController.tabBar setHeight:50.0f];
    self.tabBarController.tabBar.userInteractionEnabled = YES;
    self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
    [self.tabBarController setViewControllers:@[homeNav,minenav,memberNav]];
    [self customizeTabBarForController:_tabBarController];
    [self.window setRootViewController:_tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"tabbar_home",
                                  @"tabbar_exercise",
                                  @"tabbar_mine"];
    NSArray *tabbarTitles = @[@"首页",@"消息",@"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_s",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_n",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabbarTitles objectAtIndex:index]];
        item.imagePositionAdjustment = UIOffsetMake(0, -2);
        item.selectedTitleAttributes = @{NSFontAttributeName: kFontSize(10.0f),NSForegroundColorAttributeName: [UIColor redColor],};
        item.unselectedTitleAttributes = @{NSFontAttributeName: kFontSize(10.0f),NSForegroundColorAttributeName: [UIColor redColor],};
        index++;
    }
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
