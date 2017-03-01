//
//  DetailViewController.m
//  LYSAlertView
//
//  Created by jk on 2017/3/1.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "DetailViewController.h"
#import "LYSAlertView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
    
    
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 120, self.view.frame.size.width - 40, 40);
    btn.layer.cornerRadius = 8;
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2;
    [self.view addSubview:btn];
}

-(void)btnClicked{
    LYSAlertView *alertView = [[LYSAlertView alloc]initWithTitle:@"温馨提示" content:@"确定拨打客服电话吗？" leftTitle:@"知道了" rightTitle:@""];
    alertView.leftBlock = ^{
        NSLog(@"左按钮被点击");
    };
    alertView.rightBlock = ^{
        NSLog(@"右按钮被点击");
    };
    [alertView showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
