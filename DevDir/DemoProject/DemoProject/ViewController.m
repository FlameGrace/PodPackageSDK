//
//  ViewController.m
//  DemoProject
//
//  Created by Flame Grace on 2019/12/20.
//  Copyright © 2019 Flame Grace. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"A";
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 44)];
    [btn setTitle:@"Support Orientation" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(allowRotation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 200, 44)];
        [btn setTitle:@"Not Support Orientation" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(notAllowRotation) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 200, 44)];
        [btn setTitle:@"Push To Next VC" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(pushToNextVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)allowRotation{
}

- (void)notAllowRotation{
}

- (void)pushToNextVC{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"B";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
