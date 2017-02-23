//
//  ViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/17.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "ViewController.h"
#import "SJLineViewController.h"
#import "SJCurveViewController.h"
#import "SJAnimationViewController.h"

static NSString *navTitle = @"分类";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSArray *itemsArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = navTitle;
    self.view.backgroundColor = kVCViewBGColor;
    self.itemsArray = @[@"直线", @"曲线", @"动画"];
    [self.view addSubview:self.mTableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDENT = @"SJSHAPELAYERID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENT];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENT];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.itemsArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            SJLineViewController *lineVC = [[SJLineViewController alloc] init];
            [self.navigationController pushViewController:lineVC animated:YES];
        }
            break;
        case 1: {
            SJCurveViewController *curveVC = [[SJCurveViewController alloc] init];
            [self.navigationController pushViewController:curveVC animated:YES];
        }
            break;
            
        case 2: {
            SJAnimationViewController *animaVC = [[SJAnimationViewController alloc] init];
            [self.navigationController pushViewController:animaVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - setUI
- (UITableView *)mTableView {
    if (_mTableView == nil) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
    }
    return _mTableView;
}

@end
