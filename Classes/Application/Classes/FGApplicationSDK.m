//
//  FGApplicationSDK.m
//  DemoProject
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "FGApplicationSDK.h"
#import "FGApplicationHomeVC.h"
#import "AFNetworking.h"

@implementation FGApplicationSDK

- (instancetype)init{
    if(self = [super init]){
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

- (UIViewController<FGApplicationMainEntranceProtocol> *)mainEntranceVC{
    return [[FGApplicationHomeVC alloc]init];
}

@end
