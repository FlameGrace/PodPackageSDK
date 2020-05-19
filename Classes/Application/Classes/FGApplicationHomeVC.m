//
//  FGApplicationHomeVC.m
//  DemoProject
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "FGApplicationHomeVC.h"
#import <FGOuterSDK/FGOuterSDK.h>
#import "FGOuterLibrary.h"
#import "NSObject+FGObserverNetWorkState.h"

@interface FGApplicationHomeVC ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation FGApplicationHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self observeNotification_ForNetWorkState_fg];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[FGBundleResourceTool imageNamed:@"application" withBundleName:@"FGApplicationBundle"]];
    imageView.frame = CGRectMake(FGMainScreenWidth/2.0 - 50/2.0, 140, 50, 50);
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    [self label];
    
}

- (void)setNumber:(NSInteger)number{
    self.label.text = [NSString stringWithFormat:@"%@-%@-%@",@(number),[FGOuterSDK text],[FGOuterLibrary text]];
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, FGMainScreenWidth-60, 40)];
        _label.text = @"0";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor greenColor];
        [self.view addSubview:_label];
    }
    return _label;
}

- (void)netWorkStateLost_fg{
    NSLog(@"FGApplicationHomeVC：失去链接");
}

- (void)netWorkStateReConnect_fg{
    NSLog(@"FGApplicationHomeVC：已经链接");
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
