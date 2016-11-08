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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) JYSuspensionBtn *ssBtn; // 悬浮按钮
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [self setupTableView];
    [self setupSSBtn];
    
    /* 测试用
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 300)];
    aView.backgroundColor = [UIColor redColor];
    // 当前顶层窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:aView];
     */
}

- (void)setupTableView{
    _tableView = [[UITableView alloc] init];
    _tableView.frame = self.view.bounds;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)setupSSBtn{
    CGFloat ssBtnW = 64;
    CGFloat ssBtnH = ssBtnW;

    _ssBtn = [[JYSuspensionBtn alloc] init];
    _ssBtn.frame = CGRectMake(self.view.right - ssBtnW, self.view.centerY - ssBtnW, ssBtnW, ssBtnH);
    [self.view addSubview:_ssBtn];
    
    // 添加点击事件
    [_ssBtn addTarget:self action:@selector(ssBtnClick) forControlEvents:UIControlEventTouchUpInside];

    // 添加拖动手势
    [_ssBtn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnDidPan:)]];
}

- (void)btnDidPan:(UIPanGestureRecognizer *)sender {
    // 位置处理逻辑封装在悬浮按钮内部，避免控制器繁重
    [_ssBtn buttonPan:sender];
}

- (void)ssBtnClick{
    NSLog(@"%s",__func__);
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"=====%zd",indexPath.row];
    return cell;
}
@end
