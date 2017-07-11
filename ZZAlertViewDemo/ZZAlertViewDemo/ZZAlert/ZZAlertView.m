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
/** 如果没有添加按钮默认添加 */
@property (nonatomic, strong) UIButton *defaultBtn;
/** 记录LeftBtn处理事件 */
@property (nonatomic, strong) LeftBtnBlock leftBlock;
/** 记录RightBtn处理事件 */
@property (nonatomic, strong) RightBtnBlock rightBlock;
/** 左侧按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *rightBtn;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 内容 */
@property (nonatomic, strong) UILabel *messageLabel;
/** 内容  第二行 */
@property (nonatomic, strong) UILabel *messageDetailLabel;
@end
@implementation ZZAlertView
#pragma mark - 初始化
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        
        CGRect frame = CGRectMake((kWidth - 230) / 2.0, (kHeight - 150) / 2.0, 230, 150);
        _showView = [[UIView alloc] initWithFrame:frame];
        _showView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
        _showView.userInteractionEnabled = YES;
        _showView.layer.cornerRadius = 5.0;
        _showView.layer.masksToBounds = YES;
        [self addSubview:_showView];
        
        frame = CGRectMake(0, 19, 230, 15);
        _titleLabel = [[UILabel alloc] initWithFrame:frame];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15.0 weight:10];
        _titleLabel.textColor = RGBColor(0x36322f, 1);
        _titleLabel.text = title;
        [_showView addSubview:_titleLabel];
        
        frame = CGRectMake(15, 51, 200, 70);
        _messageLabel = [[UILabel alloc] initWithFrame:frame];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.textColor = RGBColor(0x36322f, 1);
        _messageLabel.text = message;
        _messageLabel.numberOfLines = 0;
        CGSize labelSize = [self getSizeWithLabel:_messageLabel maxWidth:200];
        frame = _messageLabel.frame;
        frame.size.height = labelSize.height;
        _messageLabel.frame = frame;
        [_showView addSubview:_messageLabel];
        
        frame = CGRectMake(0, CGRectGetMaxY(_messageLabel.frame) + 19, 230, 0.5);
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:frame];
        line1.backgroundColor = RGBColor(0xd4d4d4, 1);
        [_showView addSubview:line1];
        
        frame = CGRectMake(0, CGRectGetMaxY(line1.frame) + 0.5, 230, 40);
        _defaultBtn = [[UIButton alloc] initWithFrame:frame];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_defaultBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_defaultBtn setTitle:@"确定" forState:UIControlStateHighlighted];
        [_defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_defaultBtn addTarget:self action:@selector(defaultBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:_defaultBtn];
        
        frame = _showView.frame;
        frame.size.height = CGRectGetMaxY(_defaultBtn.frame);
        frame.origin.y = (kHeight - frame.size.height) / 2.0;
        _showView.frame = frame;
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        visualView.frame = _showView.bounds;
        [_showView addSubview:visualView];
        [_showView insertSubview:visualView atIndex:0];
    }
    return self;
}
#pragma mark - 添加按钮 最多两个
- (UIButton *)addAction:(NSString *)title handler:(void (^)())handler {
    
    if (_defaultBtn != nil) {
        [_defaultBtn removeFromSuperview];
    }
    UIButton *addBtn;
    CGRect frame = CGRectZero;
    if (_leftBtn == nil) {
        _leftBlock = handler;
        frame = CGRectMake(0, _showView.frame.size.height - 39.5, 230, 40);
        _leftBtn = [[UIButton alloc] initWithFrame:frame];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_leftBtn setTitle:title forState:UIControlStateNormal];
        [_leftBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateNormal];
        [_leftBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateHighlighted];
        [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:_leftBtn];
        addBtn = _leftBtn;
    }else if (_rightBtn == nil) {
        _rightBlock = handler;
        frame = _leftBtn.frame;
        frame.size.width = 230 / 2.0;
        _leftBtn.frame = frame;
        frame = CGRectMake(230 / 2.0, _showView.frame.size.height - 39.5, 230 / 2.0, 40);
        _rightBtn = [[UIButton alloc] initWithFrame:frame];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_rightBtn setTitle:title forState:UIControlStateNormal];
        [_rightBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateNormal];
        [_rightBtn setTitleColor:RGBColor(0x36322f, 1) forState:UIControlStateHighlighted];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:_rightBtn];
        
        frame = CGRectMake(230 / 2.0 - 0.25, _showView.frame.size.height - 40, 0.5, 40);
        UIImageView *line = [[UIImageView alloc] initWithFrame:frame];
        line.backgroundColor = RGBColor(0xd4d4d4, 1);
        [_showView addSubview:line];
        addBtn = _rightBtn;
    }else {
        NSLog(@"RGAlertView 最多添加两个按钮，超过两个不起作用！");
    }
    return addBtn;
}
#pragma mark - 左侧按钮回调
- (void)leftBtnAction:(UIButton *)btn {
    if (_leftBlock != nil) {
        _leftBlock();
    }
    [self removeFromSuperview];
}
#pragma mark - 右侧按钮回调
- (void)rightBtnAction:(UIButton *)btn {
    if (_rightBlock != nil) {
        _rightBlock();
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
    [_showView.layer addAnimation:animation forKey:nil];
}
#pragma mark - 移除
- (void)defaultBtnAction:(UIButton *)sender {
    [self removeFromSuperview];
}
#pragma mark - 字体高度计算
- (CGSize)getSizeWithLabel:(UILabel *)modelLabel maxWidth:(CGFloat)width {
    CGSize size = [_messageLabel.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName : modelLabel.font}
                                                       context:nil].size;
    return size;
}
@end
