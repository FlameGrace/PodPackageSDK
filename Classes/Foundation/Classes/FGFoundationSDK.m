//
//  FGFoundationSDK.m
//  DemoProject
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "FGFoundationSDK.h"

@implementation FGFoundationSDK

static FGFoundationSDK *fgSDK = nil;

+ (instancetype)shareSDK{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fgSDK = [[self alloc]init];
    });
    return fgSDK;
}

- (void)setEnv:(NSInteger)env openLog:(BOOL)openLog{
    NSLog(@"env:%@,openLog:%@",@(env),@(openLog));
}

@end
