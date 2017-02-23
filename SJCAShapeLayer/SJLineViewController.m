//
//  SJLineViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/17.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJLineViewController.h"

@interface SJLineViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SJLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kNavTitle;
    self.view.backgroundColor = kVCViewBGColor;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(0, (200+10)*6);
    
    for (NSInteger i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, (200+10)*i, kDeviceWidth, 200)];
        view.backgroundColor = ColorWithHex(0xb8abbb, 1);
        view.tag = 1024+i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
        label.adjustsFontSizeToFitWidth = YES;
        label.tag = 524 + i;
        
        [view addSubview:label];
        [self.scrollView addSubview:view];
    }
    
    [self drawLine];
    [self drawDoubleLine];
    [self drawTriangle];
    [self drawLineCap];
    [self drawLineJoin];
    [self drawLineDash];
}

//单线段
- (void)drawLine {
    UIView *view = [self.view viewWithTag:1024];
    UILabel *label = [view viewWithTag:524];
    label.text = @"直线";
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 2;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = nil;
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 50)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    
    line.path = bezierPath.CGPath;
}

//多线段
- (void)drawDoubleLine {
    UIView *view = [self.view viewWithTag:1025];
    UILabel *label = [view viewWithTag:525];
    label.text = @"折线";
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 2;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = nil;
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 50)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 100)];
    [bezierPath addLineToPoint:CGPointMake(250, 150)];
    
    line.path = bezierPath.CGPath;
}

//闭合多边形
- (void)drawTriangle {
    UIView *view = [self.view viewWithTag:1026];
    UILabel *label = [view viewWithTag:526];
    label.text = @"闭合多边形";
    
    CAShapeLayer *triangle = [CAShapeLayer layer];
    triangle.lineWidth = 2;
    triangle.strokeColor = [UIColor redColor].CGColor;
    triangle.fillColor = [UIColor clearColor].CGColor;
    [view.layer addSublayer:triangle];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(kDeviceWidth/2.0, 50)];
    [bezierPath addLineToPoint:CGPointMake(kDeviceWidth/2.0-100, 150)];
    [bezierPath addLineToPoint:CGPointMake(kDeviceWidth/2.0+100, 150)];
    [bezierPath addLineToPoint:CGPointMake(kDeviceWidth/2.0, 50)];
    
    triangle.path = bezierPath.CGPath;
}

//线终点样式
- (void)drawLineCap {
    UIView *view = [self.view viewWithTag:1027];
    UILabel *label = [view viewWithTag:527];
    label.text = @"线端点样式";
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 10;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = nil;
    line.lineCap = kCALineCapButt;
//    line.lineCap = kCALineCapRound;
//    line.lineCap = kCALineCapSquare;
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 50)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 100)];
    [bezierPath addLineToPoint:CGPointMake(250, 150)];
    line.path = bezierPath.CGPath;
    
}

//线拐点处样式
- (void)drawLineJoin {
    UIView *view = [self.view viewWithTag:1028];
    UILabel *label = [view viewWithTag:528];
    label.text = @"线拐点处样式";
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 10;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = nil;
    line.lineJoin = kCALineJoinMiter;
//    line.lineJoin = kCALineJoinRound;
//    line.lineJoin = kCALineJoinBevel;
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 50)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 100)];
    [bezierPath addLineToPoint:CGPointMake(250, 150)];
    
    line.path = bezierPath.CGPath;
}

//虚线
- (void)drawLineDash {
    UIView *view = [self.view viewWithTag:1029];
    UILabel *label = [view viewWithTag:529];
    label.text = @"虚线";
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 2;
    line.strokeColor = [UIColor orangeColor].CGColor;
    line.fillColor = nil;
    line.lineJoin = kCALineJoinMiter;
    line.lineDashPattern = @[@10,@5,@2,@8];
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 50)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 100)];
    [bezierPath addLineToPoint:CGPointMake(250, 150)];
    
    line.path = bezierPath.CGPath;
}


- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    }
    return _scrollView;
}
@end
