//
//  ZZAlertView.h
//  ZZAlertViewDemo
//
//  Created by Cheng Rong on 2017/7/7.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ZZShowLocation) {
    zShowCenter = 0,        //居中展示
    zShowBottom,            //底部展示
};
@interface ZZAlertView : UIView
/**
 初始化方法
 @param title     标题
 @param content   内容 
 */
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;
/**
 展示
 */
- (void)show;
/**
 添加底部事件 最多添加两个
 @param title   标题
 @param handler block事件
 */
- (UIButton *)addAction:(NSString *)title handler:(void (^)())handler;
/**
 toast提示
 @param toast 提示内容
 @param duration 展示时间
 @param location 展示位置
 @param animation 是否显示动画
 */
+ (void)makeToast:(NSString *)toast duration:(CGFloat)duration location:(ZZShowLocation)location animation:(BOOL)animation;
@end
