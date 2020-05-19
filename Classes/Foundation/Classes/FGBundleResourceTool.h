//
//  LMVLocalizableTool.h
//  Flame GraceCarOwner
//
//  Created by Mac on 2020/3/6.
//  Copyright © 2020 Flame Grace. All rights reserved.
//  读取资源文件，若预定义FGMainPro，则默认从mainBundle中读取，便于调试

#import <UIKit/UIKit.h>

@interface FGBundleResourceTool : NSObject

+ (UIImage *)imageNamed:(NSString *)imageName
         withBundleName:(NSString *)bundleName;

+ (NSString *)appendingFilePathAfterBundlePath:(NSString *)filePath
                                withBundleName:(NSString *)bundleName;

+ (NSString *)localizableStringForKey:(NSString *)key
                       withBundleName:(NSString *)bundleName;

+ (NSBundle *)bundleWithName:(NSString *)bundleName;
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName
                           podName:(NSString *)podName;

@end
