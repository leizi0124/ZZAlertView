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
    
    self.view.backgroundColor = [UIColor blueColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZZAlertView *alert = [[ZZAlertView alloc] initWithTitle:@"提示" message:@"哈哈哈哈哈哈哈哈哈哈哈哈"];
    [alert addAction:@"确定" handler:^{
        NSLog(@"确定");
    }];
    [alert addAction:@"取消" handler:^{
        NSLog(@"取消");
    }];
    [alert show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
