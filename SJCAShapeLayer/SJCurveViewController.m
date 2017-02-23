//
//  SJCurveViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/17.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJCurveViewController.h"

@interface SJCurveViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SJCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.title = kNavTitle;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(0, (200+10)*5);
    
    for (NSInteger i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, (200+10)*i, kDeviceWidth, 200)];
        view.backgroundColor = ColorWithHex(0xb8abbb, 1);
        view.tag = 1024+i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
        label.adjustsFontSizeToFitWidth = YES;
        label.tag = 524 + i;
        
        [view addSubview:label];
        [self.scrollView addSubview:view];
    }
    
    [self drawCurveOne];
    [self drawCurveTwo];
    [self drawCircle];
    [self drawMask];
    [self drawRectRound];
}


- (void)drawCurveOne {
    UIView *view = [self.view viewWithTag:1024];
    UILabel *label = [view viewWithTag:524];
    label.text = @"二次贝塞尔曲线";
    
    //三个点 起点 pA、终点 pB、一个控制点 pC
    CGPoint pA = CGPointMake(100, 150);
    CGPoint pB = CGPointMake(300, 150);
    CGPoint pC = CGPointMake(200, 50);
    
    //定义三个小矩形点放在这三个点上面方便观察
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(pA.x, pA.y, 5, 5);
    layer1.backgroundColor = [UIColor orangeColor].CGColor;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(pB.x, pB.y, 5, 5);
    layer2.backgroundColor = [UIColor orangeColor].CGColor;
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(pC.x, pC.y, 5, 5);
    layer3.backgroundColor = [UIColor orangeColor].CGColor;
    
    [view.layer addSublayer:layer1];
    [view.layer addSublayer:layer2];
    [view.layer addSublayer:layer3];
    //曲线
    CAShapeLayer *layerOne = [CAShapeLayer layer];
    layerOne.fillColor = [UIColor clearColor].CGColor;
    layerOne.strokeColor = [UIColor blackColor].CGColor;
    layerOne.strokeStart = 0;
    layerOne.strokeEnd = 1;
    [view.layer addSublayer:layerOne];
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pB controlPoint:pC];
    
    //关联路径
    layerOne.path = path.CGPath;
}

- (void)drawCurveTwo {
    UIView *view = [self.view viewWithTag:1025];
    UILabel *label = [view viewWithTag:525];
    label.text = @"三次贝塞尔曲线";
    
    //四个个点 起点pA、终点pB、两个控制点pC,pD
    CGPoint pA = CGPointMake(100, 100);
    CGPoint pB = CGPointMake(300, 100);
    CGPoint pC = CGPointMake(150, 50);
    CGPoint pD = CGPointMake(250, 150);
    
    //定义三个小矩形点放在这三个点上面方便观察
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(pA.x, pA.y, 5, 5);
    layer1.backgroundColor = [UIColor orangeColor].CGColor;
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(pB.x, pB.y, 5, 5);
    layer2.backgroundColor = [UIColor orangeColor].CGColor;
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(pC.x, pC.y, 5, 5);
    layer3.backgroundColor = [UIColor orangeColor].CGColor;
    
    CALayer *layer4 = [CALayer layer];
    layer4.frame = CGRectMake(pD.x, pD.y, 5, 5);
    layer4.backgroundColor = [UIColor orangeColor].CGColor;
    
    [view.layer addSublayer:layer1];
    [view.layer addSublayer:layer2];
    [view.layer addSublayer:layer3];
    [view.layer addSublayer:layer4];
    
    //曲线
    CAShapeLayer *layerTwo = [CAShapeLayer layer];
    layerTwo.fillColor = [UIColor clearColor].CGColor;
    layerTwo.strokeColor = [UIColor blackColor].CGColor;
    layerTwo.strokeStart = 0;
    layerTwo.strokeEnd = 1;
    [view.layer addSublayer:layerTwo];
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addCurveToPoint:pB controlPoint1:pC controlPoint2:pD];
    
    //关联路径
    layerTwo.path = path.CGPath;
}

//内切圆（椭圆或圆）
- (void)drawCircle {
    UIView *view = [self.view viewWithTag:1026];
    UILabel *label = [view viewWithTag:526];
    label.text = @"内切圆";
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2.0-100, 20, 200, 160)];
    tempView.backgroundColor = [UIColor cyanColor];
    [view addSubview:tempView];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:tempView.bounds];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.lineWidth = 2;
    circle.strokeColor = [UIColor orangeColor].CGColor;
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.path = bezierPath.CGPath;
    
    [tempView.layer addSublayer:circle];
}

//mask裁剪
- (void)drawMask {
    UIView *view = [self.view viewWithTag:1027];
    UILabel *label = [view viewWithTag:527];
    label.text = @"mask裁剪内切圆";
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2.0-100, 20, 200, 160)];
    tempView.backgroundColor = [UIColor cyanColor];
    [view addSubview:tempView];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:tempView.bounds];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.lineWidth = 2;
    line.strokeColor = [UIColor clearColor].CGColor;
    line.fillColor = [UIColor orangeColor].CGColor;
    line.path = bezierPath.CGPath;
    
    tempView.layer.mask = line;
}

//圆角矩形
- (void)drawRectRound {
    UIView *view = [self.view viewWithTag:1028];
    UILabel *label = [view viewWithTag:528];
    label.text = @"圆角矩形，随心所欲设置一个或多个圆角";
    
    UIBezierPath *rectRound = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kDeviceWidth/2.0-100, 50, 200, 100) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.path = rectRound.CGPath;
    
    [view.layer addSublayer:layer];
}


- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    }
    return _scrollView;
}

@end
