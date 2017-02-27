//
//  SJAnimationViewController.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/20.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJAnimationViewController.h"

#define kItemsCount     7
@interface SJAnimationViewController ()
{
    CAShapeLayer *line;
    CAShapeLayer *bar;
    CAShapeLayer *curve;
    CAShapeLayer *circle;
    CAShapeLayer *circleTwo;
    CAShapeLayer *circleProgress;
    CAShapeLayer *xuCircle;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CABasicAnimation *animComm;
@property (nonatomic, strong) CABasicAnimation *animProgress;
@property (nonatomic, strong) CABasicAnimation *animRepeat;
@end

@implementation SJAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.title = kNavTitle;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(0, (200+10)*kItemsCount);
    
    [self setUI];
}

- (void)setUI {
    for (NSInteger i = 0; i < kItemsCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, (200+10)*i, kDeviceWidth, 200)];
        view.backgroundColor = ColorWithHex(0xb8abbb, 1);
        view.tag = 1024+i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
        label.tag = 524 + i;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 104 + i;
        btn.frame = CGRectMake(kDeviceWidth - 100, 20, 50, 30);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"动画" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(refreshAnimation:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        [view addSubview:label];
        [self.scrollView addSubview:view];
    }
    
    [self ani_line];
    [self ani_bar];
    [self ani_curve];
    [self ani_circle];
    [self ani_circleTwo];
    [self ani_circleProgress];
    [self ani_drawXuCircle];
}

- (void)refreshAnimation:(UIButton *)btn {
    //
    switch (btn.tag) {
        case 104:
            [line addAnimation:self.animComm forKey:nil];
            break;
        case 105:
            [bar addAnimation:self.animComm forKey:nil];
            break;
        case 106:
            [curve addAnimation:self.animComm forKey:nil];
            break;
        case 107:
            [circle addAnimation:self.animComm forKey:nil];
            break;
        case 108:
            [circleTwo addAnimation:self.animRepeat forKey:nil];
            break;
        case 109:
            [circleProgress addAnimation:self.animProgress forKey:nil];
            break;
        case 110:
            [xuCircle addAnimation:self.animProgress forKey:nil];
            break;
        default:
            break;
    }
}

//直线动画
- (void)ani_line {
    UIView *view = [self.view viewWithTag:1024];
    UILabel *label = [view viewWithTag:524];
    label.text = @"直线动画";
    
    line = [CAShapeLayer layer];
    line.lineWidth = 2;
    line.strokeColor = [UIColor blackColor].CGColor;
    line.fillColor = nil;
    [view.layer addSublayer:line];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 150)];
    [bezierPath addLineToPoint:CGPointMake(300, 50)];
    line.path = bezierPath.CGPath;
    [line addAnimation:self.animComm forKey:nil];
}

//柱状动画(线宽较大)
- (void)ani_bar {
    UIView *view = [self.view viewWithTag:1025];
    UILabel *label = [view viewWithTag:525];
    label.text = @"柱状动画";
    
    bar = [CAShapeLayer layer];
    bar.lineWidth = 50;
    bar.strokeColor = [UIColor blackColor].CGColor;
    bar.fillColor = nil;
    [view.layer addSublayer:bar];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(kDeviceWidth/2.0, 180)];
    [bezierPath addLineToPoint:CGPointMake(kDeviceWidth/2.0, 50)];
    bar.path = bezierPath.CGPath;
    [bar addAnimation:self.animComm forKey:nil];
}

//曲线动画
- (void)ani_curve {
    UIView *view = [self.view viewWithTag:1026];
    UILabel *label = [view viewWithTag:526];
    label.text = @"曲线动画";
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
    curve = [CAShapeLayer layer];
    curve.fillColor = [UIColor clearColor].CGColor;
    curve.strokeColor = [UIColor blackColor].CGColor;
    curve.strokeStart = 0;
    curve.strokeEnd = 1;
    [view.layer addSublayer:curve];
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pB controlPoint:pC];
    
    //关联路径
    curve.path = path.CGPath;
    [curve addAnimation:self.animComm forKey:nil];
}

//圆形动画
- (void)ani_circle {
    UIView *view = [self.view viewWithTag:1027];
    UILabel *label = [view viewWithTag:527];
    label.text = @"圆形动画";
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kDeviceWidth/2.0-50, 50, 100, 100)];
    
    circle = [CAShapeLayer layer];
    circle.lineWidth = 2;
    circle.strokeColor = [UIColor orangeColor].CGColor;
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.path = bezierPath.CGPath;
    
    [view.layer addSublayer:circle];
    [circle addAnimation:self.animComm forKey:nil];

}

//有重复次数，有逆执行
- (void)ani_circleTwo {
    UIView *view = [self.view viewWithTag:1028];
    UILabel *label = [view viewWithTag:528];
    label.text = @"有重复次数和逆执行";
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kDeviceWidth/2.0-50, 50, 100, 100)];
    
    circleTwo = [CAShapeLayer layer];
    circleTwo.lineWidth = 2;
    circleTwo.strokeColor = [UIColor orangeColor].CGColor;
    circleTwo.fillColor = [UIColor clearColor].CGColor;
    circleTwo.path = bezierPath.CGPath;
    
    [view.layer addSublayer:circleTwo];
}

//圆形进度条
- (void)ani_circleProgress {
    UIView *view = [self.view viewWithTag:1029];
    UILabel *label = [view viewWithTag:529];
    label.text = @"圆形进度条";
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kDeviceWidth/2.0-50, 50, 100, 100)];
    //背景圆
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.lineWidth = 5.0;
    bgLayer.strokeColor = [UIColor grayColor].CGColor;
    bgLayer.fillColor = [UIColor clearColor].CGColor;
    bgLayer.path = bezierPath.CGPath;
    [view.layer addSublayer:bgLayer];
    
    
    circleProgress = [CAShapeLayer layer];
    circleProgress.lineWidth = 5.0;
    circleProgress.strokeColor = [UIColor redColor].CGColor;
    circleProgress.fillColor = [UIColor clearColor].CGColor;
    circleProgress.lineCap = kCALineCapRound;
    circleProgress.path = bezierPath.CGPath;
    
    [view.layer addSublayer:circleProgress];
    [circleProgress addAnimation:self.animProgress forKey:nil];
}

//虚线
- (void)ani_drawXuCircle {
    UIView *view = [self.view viewWithTag:1030];
    UILabel *label = [view viewWithTag:530];
    label.text = @"虚线圆（进度圆）";
    
    //底部虚圆
    CAShapeLayer *bgCircle = [CAShapeLayer layer];
    bgCircle.lineWidth = 10;
    bgCircle.strokeColor = ColorWithHex(0xbebebe, 1).CGColor;
    bgCircle.fillColor = nil;
    bgCircle.lineJoin = kCALineJoinMiter;
    bgCircle.lineDashPattern = @[@2,@3];
    [view.layer addSublayer:bgCircle];
    
    //外部虚圆
    xuCircle = [CAShapeLayer layer];
    xuCircle.lineWidth = 10;
    xuCircle.strokeColor = ColorWithHex(0xa2d100, 1).CGColor;
    xuCircle.fillColor = nil;
    xuCircle.lineJoin = kCALineJoinMiter;
    xuCircle.lineDashPattern = @[@2,@3];
    [view.layer addSublayer:xuCircle];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kDeviceWidth/2.0, 100) radius:55 startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    
    bgCircle.path = bezierPath.CGPath;
    xuCircle.path = bezierPath.CGPath;
    [xuCircle addAnimation:self.animProgress forKey:nil];
}



- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    }
    return _scrollView;
}

//普通动画，strokeEnd
- (CABasicAnimation *)animComm {
    if (_animComm == nil) {
        _animComm = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animComm.fromValue = @0.0;
        _animComm.toValue = @1.0;
        _animComm.duration = 2.0;
    }
    return _animComm;
}

//进度条动画
- (CABasicAnimation *)animProgress {
    if (_animProgress == nil) {
        _animProgress = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animProgress.fromValue = @0.0;
        _animProgress.toValue = @0.7;
        _animProgress.fillMode = kCAFillModeForwards;
        _animProgress.removedOnCompletion = NO;
        _animProgress.duration = 2.0;
    }
    return _animProgress;
}


//重复次数，逆执行试用
- (CABasicAnimation *)animRepeat {
    if (_animRepeat == nil) {
        _animRepeat = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animRepeat.fromValue = @0.0;
        _animRepeat.toValue = @1.0;
        _animRepeat.duration = 2.0;
        _animRepeat.autoreverses = YES;
        _animRepeat.repeatCount = 10;
    }
    return _animRepeat;
}

@end
