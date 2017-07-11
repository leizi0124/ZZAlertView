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
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    ZZAlertView *alert = [[ZZAlertView alloc] initWithTitle:@"提示" content:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
//    [alert addAction:@"确定" handler:^{
//        NSLog(@"确定");
//    }];
//    [alert addAction:@"取消" handler:^{
//        NSLog(@"取消");
//    }];
//    [alert show];
    
    [ZZAlertView makeToast:@"爽肤水地方还US发hi阿斯符合萨芬" duration:2.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
