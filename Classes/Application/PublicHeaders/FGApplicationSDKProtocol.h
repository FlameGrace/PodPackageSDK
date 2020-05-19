//
//  FGApplicationSDKProtocol.h
//  DemoProject
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGFoundationSDKProtocol.h"
#import "FGApplicationMainEntranceProtocol.h"

@protocol FGApplicationSDKProtocol <FGFoundationSDKProtocol>

- (UIViewController <FGApplicationMainEntranceProtocol> *)mainEntranceVC;

@end

