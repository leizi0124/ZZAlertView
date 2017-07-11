//
//  ZZAlertView.m
//  ZZAlertViewDemo
//
//  Created by Cheng Rong on 2017/7/7.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ZZAlertView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define RGBColor(rgb,yourAlpha) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:yourAlpha]

typedef void (^LeftBtnBlock)();
typedef void (^RightBtnBlock)();
@interface ZZAlertView ()
/** 显示 */
@property (nonatomic, strong) UIView *showView;
/**
 如果没有添加按钮默认添加
 */
@property (nonatomic, strong) UIButton *defaultBtn;
/**
 记录LeftBtn处理事件
 */
@property (nonatomic, strong) LeftBtnBlock leftBlock;
/**
 记录RightBtn处理事件
 */
@property (nonatomic, strong) RightBtnBlock rightBlock;
@end
@implementation ZZAlertView
#pragma mark - 初始化
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message backgroundImage:(NSString *)imageName {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgImage.backgroundColor = [UIColor blackColor];
        bgImage.alpha = 0.4;
        [self addSubview:bgImage];
        
        CGRect frame = CGRectMake((kWidth - 230) / 2.0, (kHeight - 150) / 2.0, 230, 150);
        self.showView = [[UIView alloc] initWithFrame:frame];
        self.showView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        self.showView.userInteractionEnabled = YES;
        self.showView.layer.cornerRadius = 5.0;
        self.showView.layer.masksToBounds = YES;
        [self addSubview:self.showView];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualView.frame = CGRectMake(0, 0, self.showView.frame.size.width, self.showView.frame.size.height);
        [self.showView addSubview:visualView];
        
        if (imageName != nil) {
            frame = self.showView.bounds;
            UIImageView *showViewBg = [[UIImageView alloc] initWithFrame:frame];
            showViewBg.image = [UIImage imageNamed:imageName];
            [self.showView addSubview:showViewBg];
        }
        
        frame = CGRectMake(0, 19, 230, 15);
        self.titleLabel = [[UILabel alloc] initWithFrame:frame];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0 weight:10];
        self.titleLabel.textColor = RGBColor(0x36322f, 1);
        self.titleLabel.text = title;
        [self.showView addSubview:self.titleLabel];
        
        NSArray *messageArray = [message componentsSeparatedByString:@"*"];
        if (messageArray.count == 2) {
            frame = CGRectMake(0, 51, 230, 15);
            message = messageArray[0];
            self.messageLabel = [[UILabel alloc] initWithFrame:frame];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = [UIFont systemFontOfSize:14.0];
            self.messageLabel.textColor = RGBColor(0x36322f, 1);
            self.messageLabel.text = message;
            [self.showView addSubview:self.messageLabel];
            
            frame = CGRectMake(0, 74, 230, 15);
            message = messageArray[1];
            self.messageDetailLabel = [[UILabel alloc] initWithFrame:frame];
            self.messageDetailLabel.backgroundColor = [UIColor clearColor];
            self.messageDetailLabel.textAlignment = NSTextAlignmentCenter;
            self.messageDetailLabel.font = [UIFont systemFontOfSize:14.0];
            self.messageDetailLabel.textColor = RGBColor(0x36322f, 1);
            self.messageDetailLabel.text = message;
            [self.showView addSubview:self.messageDetailLabel];
        }else {
            frame = self.showView.frame;
            frame.size.height -= 20;
            self.showView.frame = frame;
            
            frame = CGRectMake(0, 51, 230, 15);
            self.messageLabel = [[UILabel alloc] initWithFrame:frame];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = [UIFont systemFontOfSize:14.0];
            self.messageLabel.textColor = RGBColor(0x36322f, 1);
            self.messageLabel.text = message;
            [self.showView addSubview:self.messageLabel];
        }
        
        frame = CGRectMake(0, self.showView.frame.size.height - 40, 230, 0.5);
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:frame];
        line1.backgroundColor = RGBColor(0xd4d4d4, 1);
        [self.showView addSubview:line1];
        
        frame = CGRectMake(0, self.showView.frame.size.height - 39.5, 230, 40);
        self.defaultBtn = [[UIButton alloc] initWithFrame:frame];
        self.defaultBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.defaultBtn setTitle:@"确定" forState:UIControlStateHighlighted];
        [self.defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.defaultBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.defaultBtn];
        
    }
    return self;
}
#pragma mark - 添加按钮 最多两个
- (UIButton *)addAction:(NSString *)title handler:(void (^)())handler {
    
    if (self.defaultBtn != nil) {
        [self.defaultBtn removeFromSuperview];
    }
    UIButton *addBtn;
    CGRect frame = CGRectZero;
    if (self.leftBtn == nil) {
        self.leftBlock = handler;
        frame = CGRectMake(0, self.showView.frame.size.height - 39.5, 230, 40);
        self.leftBtn = [[UIButton alloc] initWithFrame:frame];
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.leftBtn setTitle:title forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateHighlighted];
        [self.leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.leftBtn];
        addBtn = self.leftBtn;
    }else if (self.rightBtn == nil) {
        self.rightBlock = handler;
        frame = self.leftBtn.frame;
        frame.size.width = 230 / 2.0;
        self.leftBtn.frame = frame;
        frame = CGRectMake(230 / 2.0, self.showView.frame.size.height - 39.5, 230 / 2.0, 40);
        self.rightBtn = [[UIButton alloc] initWithFrame:frame];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.rightBtn setTitle:title forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateHighlighted];
        [self.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.rightBtn];
        
        frame = CGRectMake(230 / 2.0 - 0.25, self.showView.frame.size.height - 40, 0.5, 40);
        UIImageView *line = [[UIImageView alloc] initWithFrame:frame];
        line.backgroundColor = RGBColor(0xd4d4d4, 1);
        [self.showView addSubview:line];
        addBtn = self.rightBtn;
    }else {
        NSLog(@"RGAlertView 最多添加两个按钮，超过两个不起作用！");
    }
    return addBtn;
}
#pragma mark - 左侧按钮回调
- (void)leftBtnAction:(UIButton *)btn {
    if (self.leftBlock != nil) {
        self.leftBlock();
    }
    [self removeFromSuperview];
}
#pragma mark - 右侧按钮回调
- (void)rightBtnAction:(UIButton *)btn {
    if (self.rightBlock != nil) {
        self.rightBlock();
    }
    [self removeFromSuperview];
}
#pragma mark - 显示
- (void)show {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.03, 1.03, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.00, 1.00, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.01, 1.01, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.99, 0.99, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.showView.layer addAnimation:animation forKey:nil];
}
#pragma mark - 移除
- (void)defaultBtnAction:(UIButton *)sender {
    [self removeFromSuperview];
}
@end
