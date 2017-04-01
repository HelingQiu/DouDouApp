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
#import "DouDouBaseNavigationController.h"
#import "DouDouLoginViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MemberCenterViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "IanAdsStartView.h"

#define JPushAppKey @"b3c6bc7fac7469238a9fb0f8"
@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>
{
    BMKMapManager* _mapManager;
}
@property (nonatomic, strong) RDVTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiDuAppKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //极光
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    [self setUpViewControllers];
    
//    [self.window setRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"]];
    
    return YES;
}

- (void)setUpViewControllers{
    // Root view controller
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    DouDouBaseNavigationController *homeNav = [[DouDouBaseNavigationController alloc]initWithRootViewController:homeViewController];
    
    MessageViewController *messageController = [MessageViewController createByNibFile];
    DouDouBaseNavigationController *messageNav = [[DouDouBaseNavigationController alloc]initWithRootViewController:messageController];
    
    MemberCenterViewController *memberController = [MemberCenterViewController createByNibFile];
    DouDouBaseNavigationController *memberNav = [[DouDouBaseNavigationController alloc]initWithRootViewController:memberController];
    
    
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
    [self.tabBarController setViewControllers:@[homeNav,messageNav,memberNav]];
    [self customizeTabBarForController:_tabBarController];
    [self.window setRootViewController:_tabBarController];
    
    
    //Get bundle version
    NSString *bundleVersion = kAPPVersion;
    //Get saved bundle version
    NSString *previousVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kAppGuideVersion];
    //Compare saved bundle version and bundle version
    if (previousVersion == nil || ![previousVersion isEqualToString:bundleVersion]) {
        
        //显示引导页
        
        [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:@"previousVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        //启动广告图
        NSString *picUrl = @"http://785j3g.com1.z0.glb.clouddn.com/d659db60-f.jpg";
        if ([[[NSUserDefaults standardUserDefaults] stringForKey:kAdsKey] isEqualToString:@"1"]) {
            IanAdsStartView *startView = [IanAdsStartView startAdsViewWithBgImageUrl:picUrl withClickImageAction:^{
                
            }];
            
            [startView startAnimationTime:3 WithCompletionBlock:^(IanAdsStartView *startView){
                NSLog(@"广告结束后，执行事件");
            }];
        } else { // 第一次先下载广告
            [IanAdsStartView downloadStartImage:picUrl];
            
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:kAdsKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"tabbar_home",
                                  @"tabbar_message",
                                  @"tabbar_member"];
    NSArray *tabbarTitles = @[@"首页",@"消息",@"我的"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabbarTitles objectAtIndex:index]];
        item.imagePositionAdjustment = UIOffsetMake(0, -2);
        item.selectedTitleAttributes = @{NSFontAttributeName: kFontSize(12.0f),NSForegroundColorAttributeName: kHexColor(kColor_Mian),};
        item.unselectedTitleAttributes = @{NSFontAttributeName: kFontSize(12.0f),NSForegroundColorAttributeName: [UIColor blackColor],};
        index++;
    }
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
//    [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
//        [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
//        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
//        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

#pragma mark - 支付方式
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            //通知支付页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayNoti object:resultDic];
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            //通知支付页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kAlipayNoti object:resultDic];
        }];
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma - wxpay
- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        //通知支付页面
        [[NSNotificationCenter defaultCenter] postNotificationName:kWeixinNoti object:response];
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}

@end
