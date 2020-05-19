//
//  LMVLocalizableTool.m
//  Flame GraceCarOwner
//
//  Created by Mac on 2020/3/6.
//  Copyright © 2020 Flame Grace. All rights reserved.
//

#import "FGBundleResourceTool.h"

@implementation FGBundleResourceTool

+ (UIImage *)imageNamed:(NSString *)imageName
         withBundleName:(NSString *)bundleName{
        return [self imageNamed:imageName withBundleName:bundleName ofType:nil];
}

+ (NSString *)appendingFilePathAfterBundlePath:(NSString *)filePath
                                withBundleName:(NSString *)bundleName{
    if(!filePath){
        return nil;
    }
    NSBundle *bundle = [self bundleWithName:bundleName];
    NSString *path = [[bundle bundlePath] stringByAppendingPathComponent:filePath];
    return path;
}

+ (UIImage *)imageNamed:(NSString *)imageName
         withBundleName:(NSString *)bundleName
                 ofType:(NSString *)type{
    if(!type){
        type = @"png";
    }
    NSBundle *bundle = [self bundleWithName:bundleName];
    if (bundle && imageName) {
        if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
            return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
        } else {
            NSString *imagePath = [[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName,type]];
            return [UIImage imageWithContentsOfFile:imagePath];
        }
    }
    return nil;
}

+ (NSString *)localizableStringForKey:(NSString *)key
                       withBundleName:(NSString *)bundleName{
    NSBundle *bundle = [self bundleWithName:bundleName];
    return NSLocalizedStringFromTableInBundle(key,nil, bundle, nil);
}

+ (NSBundle *)bundleWithName:(NSString *)name{
#ifdef FGMainPro
    return [NSBundle mainBundle];
#else
    return [self bundleWithBundleName:name podName:nil];
#endif
}

/**
 获取文件所在name，默认情况下podName和bundlename相同，传一个即可
 
 @param bundleName bundle名字，就是在resource_bundles里面的名字
 @param podName pod的名字
 @return bundle
 */
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName podName:(NSString *)podName{
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    }else if (bundleName == nil ) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        if(associateBundleURL){
            NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
            associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
        }
    }
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}



@end
