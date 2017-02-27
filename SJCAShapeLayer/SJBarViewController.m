//
//  SJBarViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/23.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJBarViewController.h"
#import "SJBarChart.h"

@interface SJBarViewController ()

@end

@implementation SJBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.title = @"📊";
    
    //假数据
    NSArray *sourceArray = @[@20, @30, @40, @25, @20, @10, @5];
    
    SJBarChart *barChart = [[SJBarChart alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 300)];
    [barChart showBarChart:sourceArray];
    [self.view addSubview:barChart];

}

@end
