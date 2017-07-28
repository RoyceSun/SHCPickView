//
//  ViewController.m
//  SHCPickView
//
//  Created by gcct on 2017/7/26.
//  Copyright © 2017年 sunhaichen. All rights reserved.
//

#import "ViewController.h"
#import "SHCPickView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.backgroundColor = [UIColor redColor];
    but.frame = CGRectMake(50, 50, 100, 50);
    [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];

}
- (void)butAction:(UIButton *)sender
{
    SHCPickView *pickView = [SHCPickView showInView:self.view didSelectWithBlock:^(NSString *ourAddress, NSString *province, NSString *city) {
        NSLog(@"%@",ourAddress);
    } cancelBlock:^{
        
    }];
    pickView.inActionType = SHCCity;
    pickView.arratData = [NSMutableArray arrayWithObjects:@"甘肃省",@"广东省",@"四川省",@"贵州省",@"山东省",@"山西省",@"东北省",@"海南省",@"广西省",@"河北省",@"河南省",@"西藏省",@"台湾省",@"香港省",@"新疆省",@"上海", nil];
    pickView.viewHeight = 300;
    pickView.interval = 0.2;
    
//    pickView.inActionType = SHCBank;
//    pickView.arratData = [NSMutableArray arrayWithObjects:@"中国银行",@"建设银行",@"广州银行",@"贵州银行",@"招商银行",@"交通银行",@"北京银行",@"南京银行",@"甘肃银行",@"兰州银行",@"中央银行",@"中原银行",@"农村信用社",@"上海银行",@"苏州银行",@"南通银行", nil];
//    pickView.viewHeight = 200;
//    pickView.interval = 0.2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
