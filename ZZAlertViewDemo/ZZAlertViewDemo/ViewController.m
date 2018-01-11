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
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            ZZAlertView *alert = [[ZZAlertView alloc] initWithTitle:@"提示" content:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
            [alert addAction:@"确定" handler:^{
                NSLog(@"确定");
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
