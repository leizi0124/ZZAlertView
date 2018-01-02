//
//  ViewController.m
//  ZZAlertViewDemo
//
//  Created by Cheng Rong on 2017/7/7.
//  Copyright © 2017年 Zhao Zhenlei. All rights reserved.
//

#import "ViewController.h"
#import "ZZAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSArray *titleArray = @[@"alert",@"toast"];
    
    CGRect frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width / titleArray.count, 50);
    NSInteger index = 100;
    
    for (NSString *title in titleArray) {
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.tag = index++;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        frame = CGRectOffset(frame, frame.size.width, 0);
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 20)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"哈哈哈哈哈";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // 创建渐变效果的layer
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = label.bounds;
    graLayer.colors = @[(__bridge id)[[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor,
                        (__bridge id)[UIColor whiteColor].CGColor,
                        (__bridge id)[[UIColor clearColor]colorWithAlphaComponent:0.5].CGColor];

    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0.1);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点
    
    // 创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.duration = 1.0f;
    animation.toValue = @[@(0.9), @(1.0), @(1.0)];
    animation.removedOnCompletion = YES;
    animation.repeatCount = 100;
    animation.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:animation forKey:@"xindong"];
    
    // 将graLayer设置成textLabel的遮罩
//    label.layer.mask = graLayer;
    [label.layer addSublayer:graLayer];
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            ZZAlertView *alert = [[ZZAlertView alloc] initWithTitle:@"提示" content:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
            [alert addAction:@"确定" handler:^{
                NSLog(@"确定");
            }];
            [alert addAction:@"取消" handler:^{
                NSLog(@"取消");
            }];
            [alert show];
        }
            break;
        case 101:{
            [ZZAlertView makeToast:@"爽肤水地方还US发hi阿斯符合萨芬" duration:2.0 location:zShowBottom animation:YES];
        }
            break;
        case 102:{
            
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
