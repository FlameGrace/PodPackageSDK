//
//  FGExtensionMainEntranceView.m
//  TodayWidget
//
//  Created by Flame Grace on 2020/5/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "FGExtensionMainEntranceView.h"
#import <FGOuterSDK/FGOuterSDK.h>
#import "FGOuterLibrary.h"

@interface FGExtensionMainEntranceView()

@property (strong, nonatomic) UILabel *label;

@end

@implementation FGExtensionMainEntranceView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, FGMainScreenWidth- 20 -60, 40)];
        self.label.text = @"0";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textColor = [UIColor greenColor];
        [self addSubview:self.label];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[FGBundleResourceTool imageNamed:@"extension" withBundleName:@"FGExtensionBundle"]];
        imageView.frame = CGRectMake(FGMainScreenWidth/2.0 - 20/2.0 - 50/2.0, 60, 50, 50);
        [self addSubview:imageView];
    }
    return self;
}

- (void)setNumberString:(NSString *)numberString{
    self.label.text = [NSString stringWithFormat:@"%@-%@-%@",numberString,[FGOuterSDK text],[FGOuterLibrary text]];
}


@end
