//
//  YYNCustomProgressView.h
//  YYNCustomProgressView
//
//  Created by czf1 on 17/3/13.
//  Copyright © 2017年 yangyanan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYNCustomProgressView : UIView
/**
 只需创建初始化view，并设置frame即可使用
 默认线宽为3.0f，进度条的轨道颜色为gray，进度条的颜色为white
 可根据需要在外部进行赋值
*/

@property (nonatomic,assign)CGFloat progressValue;/**< 加载的进度 */


@property(nonatomic,assign) CGFloat progressStrokeWidth;/**< 边宽 */


@property(nonatomic,strong)UIColor *progressColor;/**< 进度条颜色 */

@property(nonatomic,strong)UIColor *progressTrackColor;/**< 进度条轨道颜色 */

@property (nonatomic, strong)UILabel *progressLabel;/**< 进度值label */

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)CGFloat totalSize;/**< 上传文件的总大小 */

+ (instancetype)sharedManager;

- (void)showCircleProgressViewWithView:(UIView *)view;/**< 显示进度条 */

- (void)hidenCircleProgressView;/**< 隐藏进度条 */

@end
