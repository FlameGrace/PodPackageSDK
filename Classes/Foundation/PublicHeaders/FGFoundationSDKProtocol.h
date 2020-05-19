//
//  FGFoundationSDKProtocol.h
//  DemoProject
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FGFoundationSDKProtocol <NSObject>

+ (instancetype)shareSDK;

- (void)setEnv:(NSInteger)env openLog:(BOOL)openLog;

@end

