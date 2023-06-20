//
//  AppDelegate.m
//  iOSApp
//
//  Created by huanghuaxing on 2023/6/19.
//

#import "AppDelegate.h"
#import <Flutter/Flutter.h>
#import "BoostDelegate.h"
#import "ViewController.h"
#import <flutter_boost/FlutterBoost.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 兼容iOS13以前的项目AppDelegate和SceneDelegate类方法里设置
    if (@available(iOS 13.0, *)) {
        
    } else {
        
        // 默认方法
        BoostDelegate *boostDelegate = [[BoostDelegate alloc ] init];
        UIApplication *application = [UIApplication sharedApplication];
        [[FlutterBoost instance] setup:application delegate:boostDelegate callback:^(FlutterEngine *engine) {
            
        }];
        
        // 原生页面
        ViewController *vc = [[ViewController alloc] initWithNibName:nil bundle:nil];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Native" image:nil tag:0];
        
        // flutter页面
        FBFlutterViewContainer *fvc = [[FBFlutterViewContainer alloc] init];
        [fvc setName:@"mainPage" uniqueId:nil params:@{} opaque:YES];
        fvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"flutter" image:nil tag:1];
        
        
        UITabBarController *tabVC = [[UITabBarController alloc] init];
        tabVC.viewControllers = @[vc, fvc];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tabVC];
        
        boostDelegate.navigationController = nvc;
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = nvc;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
