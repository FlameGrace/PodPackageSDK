//
//  AppDelegate.h
//  DemoProject
//
//  Created by Mac on 2019/12/20.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (assign,nonatomic) BOOL supportOrientation;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootNaviCon;

@end

