//
//  ViewController.m
//  YYNCustomProgressView
//
//  Created by czf1 on 17/3/14.
//  Copyright © 2017年 杨亚楠. All rights reserved.
//

#import "ViewController.h"
#import "YYNCustomProgressView.h"

//屏幕的宽 高 比例
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong)UIButton *showBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self showBtn];
}

-(UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_showBtn];
        _showBtn.frame = CGRectMake((ScreenWidth - 100) / 2, ScreenHeight - 200, 100, 50);
        [_showBtn setTitle:@"显示进度条" forState:UIControlStateNormal];
        _showBtn.backgroundColor = [UIColor blueColor];
        [_showBtn addTarget:self action:@selector(showBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (void)showBtnClick{
    [[YYNCustomProgressView sharedManager] showCircleProgressViewWithView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
