//
//  YYNCustomProgressView.m
//  YYNCustomProgressView
//
//  Created by czf1 on 17/3/13.
//  Copyright © 2017年 yangyanan. All rights reserved.
//

#import "YYNCustomProgressView.h"

//屏幕的宽 高 
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YYNCustomProgressView()

{
    CAShapeLayer *backGroundLayer; //背景图层
    CAShapeLayer *fillLayer;      //进度条图层
    UIBezierPath *backGroundBezierPath; //背景贝赛尔曲线
    UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
    UIView *backGroudView;
}

@property (nonatomic, assign)CGFloat updateSize;

@property (nonatomic, strong) UIView *bottomView;  /**< 底层view */

@end

@implementation YYNCustomProgressView



//获取单例对象
+ (instancetype)sharedManager {
static YYNCustomProgressView *tool = nil;
//GCD语法
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    //只会调用一次
    //把对象初始化了
    tool = [[self alloc]initWithFrame:CGRectMake(0,64, ScreenWidth, ScreenHeight)];
    
    
    
});
    
    return tool;
}

- (void)showCircleProgressViewWithView:(UIView *)view{
    [self setUp];
    self.updateSize = 0.1;
    [self timer];
    [view addSubview:self];
}

-(NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(animateProgress:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)animateProgress:(NSTimer *)timer{
    self.updateSize += 0.5;
    self.totalSize = 7;

    if (self.updateSize / self.totalSize > 0.95) {
        self.progressValue = 1;
        [self hidenCircleProgressView];
    }else{
        self.progressValue = self.updateSize / self.totalSize;
    }

}

- (void)hidenCircleProgressView{
    
    if ([self.timer isValid]) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.timer invalidate];
        self.timer = nil;
    }
    self.progressValue = 1;
    [self removeFromSuperview];
}

- (void)setUp
{
    backGroudView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - 100)/2,(ScreenHeight - 200)/2, 100, 100)];
    _bottomView = backGroudView;
    backGroudView.backgroundColor = [UIColor grayColor];
    [self addSubview:backGroudView];
    
    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = nil;
    backGroundLayer.lineWidth = 3.0f;
    backGroundLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(backGroudView.frame.size.width/2, backGroudView.frame.size.height/2) radius:30 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    backGroundLayer.path = backGroundBezierPath.CGPath;
    
    //创建填充图层
    fillLayer = [CAShapeLayer layer];
    fillLayer.fillColor = nil;
    fillLayer.lineWidth = 3.0f;
    fillLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    [backGroudView.layer addSublayer:backGroundLayer];
    [backGroudView.layer addSublayer:fillLayer];
    
    _progressLabel = [[UILabel alloc]init];
    _progressLabel.frame = CGRectMake(35, 40, 30, 20);
    _progressLabel.font = [UIFont systemFontOfSize:11];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.textColor = [UIColor whiteColor];
    self.progressValue = 0.01;
    //  self.backgroundColor = [UIColor greenColor];
    [backGroudView addSubview:_progressLabel];
    
    self.backgroundColor = [UIColor clearColor];
    backGroudView.layer.cornerRadius = 2.5;
    backGroudView.clipsToBounds = YES;
    
}

- (void)setProgressColor:(UIColor *)progressColor
{
    fillLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor
{
    backGroundLayer.strokeColor = progressTrackColor.CGColor;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    if (progressValue >= 1) {
        progressValue = 1;
    }
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(backGroudView.frame.size.width/2,backGroudView.frame.size.height/2) radius:30 startAngle:-M_PI_2 endAngle:-M_PI_2 + progressValue * M_PI * 2 clockwise:YES];
    self.progressLabel.text = [NSString stringWithFormat:@"%.f%%",progressValue*100];
    fillLayer.path = frontFillBezierPath.CGPath;
    [backGroudView.layer setNeedsDisplay];
    [backGroudView setNeedsDisplay];
}

- (void)setProgressStrokeWidth:(CGFloat)progressStrokeWidth
{
    fillLayer.lineWidth = progressStrokeWidth;
    backGroundLayer.lineWidth = progressStrokeWidth;
}


@end
