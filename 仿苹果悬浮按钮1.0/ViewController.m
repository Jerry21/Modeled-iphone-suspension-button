//
//  ViewController.m
//  仿苹果悬浮按钮1.0
//
//  Created by Jerry on 16/11/8.
//  Copyright © 2016年 yejunyou. All rights reserved.
//

#import "ViewController.h"
#import "JYSuspensionBtn.h"
#import "UIView+NTES.h"

@interface ViewController ()
@property (nonatomic, strong) JYSuspensionBtn *ssBtn; // 悬浮按钮
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSSBtn];
}

- (void)setupSSBtn{
    CGFloat ssBtnW = 64;
    CGFloat ssBtnH = ssBtnW;
    
    _ssBtn = [[JYSuspensionBtn alloc] init];
    _ssBtn.frame = CGRectMake(self.view.right - ssBtnW, self.view.centerY - ssBtnW, ssBtnW, ssBtnH);
    [_ssBtn addTarget:self action:@selector(ssBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ssBtn];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnDidPan:)];
    
    //限定操作的触点数
    panGR.maximumNumberOfTouches = 1;
    panGR.minimumNumberOfTouches = 1;
    
    [_ssBtn addGestureRecognizer:panGR];
    [_ssBtn setTag:100];
}

- (void)btnDidPan:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) { // 开始拖拽
        
        //注意，这里取得的参照坐标系是该对象的上层View的坐标。
        CGPoint offset = [sender translationInView:self.view];
        UIView *draggableObj = [self.view viewWithTag:100];
        
        //通过计算偏移量来设定draggableObj的新坐标
        [draggableObj setCenter:CGPointMake(draggableObj.center.x + offset.x, draggableObj.center.y + offset.y)];
        
        //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
//        NSLog(@"moving:%@",NSStringFromCGRect(_ssBtn.frame));

    }else if ( sender.state == UIGestureRecognizerStateEnded) { // 松手
//        NSLog(@"====end:%@",NSStringFromCGRect(_ssBtn.frame));
        
        if (_ssBtn.centerX >= self.view.centerX) {
            [UIView animateWithDuration:0.5 animations:^{
                _ssBtn.right = self.view.right;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                _ssBtn.left = self.view.left;
            }];
        }
    }
}

- (void)ssBtnClick{
    NSLog(@"%s",__func__);
}
@end
