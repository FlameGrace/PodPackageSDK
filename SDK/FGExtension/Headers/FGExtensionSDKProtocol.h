//
//  FGExtensionSDKProtocol.h
//  TodayWidget
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGFoundationSDKProtocol.h"
#import "FGExtensionMainEntranceProtocol.h"

@protocol FGExtensionSDKProtocol <FGFoundationSDKProtocol>

- (UIView <FGExtensionMainEntranceProtocol> *)mainEntranceView;

@end
