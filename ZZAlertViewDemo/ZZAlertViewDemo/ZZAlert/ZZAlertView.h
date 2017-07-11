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
 左侧按钮
 */
@property (nonatomic, strong) UIButton *leftBtn;
/**
 右侧按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;
/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 内容
 */
@property (nonatomic, strong) UILabel *messageLabel;
/**
 内容  第二行
 */
@property (nonatomic, strong) UILabel *messageDetailLabel;
/**
 初始化方法
 @param title     标题
 @param message   内容 需要换行以*隔开
 @param imageName 背景图
 
 @return RGAlertView
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message backgroundImage:(NSString *)imageName;
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
