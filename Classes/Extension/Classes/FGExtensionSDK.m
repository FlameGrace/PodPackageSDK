//
//  FGExtensionSDK.m
//  TodayWidget
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "FGExtensionSDK.h"
#import "FGExtensionMainEntranceView.h"

@implementation FGExtensionSDK

- (UIView<FGExtensionMainEntranceProtocol> *)mainEntranceView{
    return [[FGExtensionMainEntranceView alloc]init];
}

@end
