//
//  AppDelegate.m
//  DemoProject
//
//  Created by Mac on 2019/12/20.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "FGApplicationSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    FGApplicationSDK *sdk = [FGApplicationSDK shareSDK];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController <FGApplicationMainEntranceProtocol> *vc = [sdk mainEntranceVC];
    [vc setNumber:40];
    self.rootNaviCon = [[UINavigationController alloc]initWithRootViewController:vc];
    self.rootNaviCon.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootNaviCon;
    [self.window makeKeyAndVisible];
    return YES;
    return YES;
}

@end
