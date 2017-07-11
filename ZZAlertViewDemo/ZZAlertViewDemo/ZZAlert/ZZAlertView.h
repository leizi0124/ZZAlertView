//
//  ZZAlertView.h
//  ZZAlertViewDemo
//
//  Created by Cheng Rong on 2017/7/7.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, zShowLocation) {
    zShowCenter = 0,        //居中展示
    zShowBottom,            //底部展示
};
@interface ZZAlertView : UIView
/**
 初始化方法
 @param title     标题
 @param message   内容 
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
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
@end
