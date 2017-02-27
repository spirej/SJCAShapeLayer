//
//  SJLineChartViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/24.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJLineChartViewController.h"
#import "SJLineChart.h"

@interface SJLineChartViewController ()

@end

@implementation SJLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.title = @"折线图";
    
    //假数据
    NSArray *sourceArray = @[@20, @25, @50, @30, @20, @25, @10, @15, @8];
    
    SJLineChart *lineChart = [[SJLineChart alloc] initWithFrame:CGRectMake(0, 100, kDeviceWidth, 300)];
    [lineChart showLineChart:sourceArray];
    [self.view addSubview:lineChart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
