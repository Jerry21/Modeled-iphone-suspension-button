//
//  JYSuspensionBtn.m
//  仿苹果悬浮按钮1.0
//
//  Created by Jerry on 16/11/8.
//  Copyright © 2016年 yejunyou. All rights reserved.
//

#import "JYSuspensionBtn.h"
#import "UIView+NTES.h"

@implementation JYSuspensionBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPan:)];
        
        //限定操作的触点数
        panGR.maximumNumberOfTouches = 1;
        panGR.minimumNumberOfTouches = 1;
        
        [self addGestureRecognizer:panGR];
        [self setTag:100];
    }
    return self;
}

- (void)buttonPan:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) { // 开始拖拽
        
        //注意，这里取得的参照坐标系是该对象的上层View的坐标。
        CGPoint offset = [sender translationInView:self.superview];
        
        
        UIView *draggableObj = [self.superview viewWithTag:100];
        
        //通过计算偏移量来设定draggableObj的新坐标
        CGFloat x = draggableObj.center.x + offset.x;
        CGFloat y = draggableObj.center.y + offset.y;
        
        if (x > self.superview.right - self.width / 2) {
            x = self.superview.right - self.width / 2;
        }else if ( x < self.superview.left + self.width / 2){
            x = self.superview.left + self.width  / 2;
        }
        
        if (y < self.superview.top + self.height / 2 + 64) {
            y = self.superview.top + self.height / 2 + 64;
        }else if (y > self.superview.bottom - self.height / 2 - 49) {
            y = self.superview.bottom - self.height / 2 - 49;
        }
        
        [draggableObj setCenter:CGPointMake(x, y)];
        
        //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
        [sender setTranslation:CGPointMake(0, 0) inView:self.superview];
        
    }else if ( sender.state == UIGestureRecognizerStateEnded) { // 松手
        
        if (self.centerX >= self.superview.centerX) {
            [UIView animateWithDuration:0.5 animations:^{
                self.right = self.superview.right;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                self.left = self.superview.left;
            }];
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
