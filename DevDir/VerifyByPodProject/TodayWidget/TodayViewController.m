//
//  TodayViewController.m
//  TodayWidget
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "FGExtensionSDK.h"

@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) UIView <FGExtensionMainEntranceProtocol> *mainEntranceView;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    if (@available(iOS 10.0, *)) {
    }else{
        self.preferredContentSize = CGSizeMake(mainScreenWidth-20, 150);
    }
    FGExtensionSDK *sdk = [FGExtensionSDK shareSDK];
    self.mainEntranceView = [sdk mainEntranceView];
    self.mainEntranceView.frame = CGRectMake(0, 0, mainScreenWidth-20, 150);
    [self.view addSubview:self.mainEntranceView];
    [self.mainEntranceView setNumberString:@"18"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize API_AVAILABLE(ios(10.0)){
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    if(activeDisplayMode == NCWidgetDisplayModeCompact){
        self.preferredContentSize = CGSizeMake(mainScreenWidth-20, 130);
    }else{
        self.preferredContentSize = CGSizeMake(mainScreenWidth-20, 150);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
