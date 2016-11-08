//
//  JYTabBarViewController.m
//  仿苹果悬浮按钮1.0
//
//  Created by Jerry on 16/11/8.
//  Copyright © 2016年 yejunyou. All rights reserved.
//

#import "JYTabBarViewController.h"
#import "JYNavigationViewController.h"
#import "ViewController.h"

@interface JYTabBarViewController ()

@end

@implementation JYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addChildVC];
}

- (void)addChildVC{
    
    ViewController *vc = [[ViewController alloc] init];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Suspension" image:[UIImage imageNamed:@"btn_moving"] selectedImage:[UIImage imageNamed:@"btn_press"]];
    JYNavigationViewController *nav = [[JYNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
