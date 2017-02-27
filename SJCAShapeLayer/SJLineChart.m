//
//  SJLineChart.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/24.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJLineChart.h"

static CGFloat const lineWidth  = 1.0;      //坐标轴线宽
static CGFloat const distance   = 20.0;     //距屏幕边距
static CGFloat const cornerW    = 10.0f;    //拐角长度
static CGFloat const space      = 50.0f;    //柱状之间的间隔
static CGFloat const scale      = 3.0f;     //直线显示高度计算比例 *scale
static CGFloat const radius     = 3.0f;     //标记每个点的小圆半径


@interface SJLineChart ()
{
    CGFloat selfW, selfH;
    NSArray *source;
}
@property (nonatomic, strong) CAShapeLayer *xAxis;
@property (nonatomic, strong) CAShapeLayer *yAxis;
@property (nonatomic, strong) UIScrollView *lineScrollView;
@property (nonatomic, strong) CABasicAnimation *animation;

@end
@implementation SJLineChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        selfW = frame.size.width;
        selfH = frame.size.height;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)showLineChart:(NSArray *)sourceArray {
    source = sourceArray;
    [self addxyAxis];
    [self addSubview:self.lineScrollView];
    _lineScrollView.contentSize = CGSizeMake(sourceArray.count*(space+1), 0);
    [self drawLineChart:sourceArray];
    [self drawPoint:sourceArray];
}

- (void)drawLineChart:(NSArray *)array {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.lineWidth = 2.0;
    //轨迹
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(space, _lineScrollView.frame.size.height - 60 - lineWidth/2.0 - ([[array objectAtIndex:0] floatValue] * scale))];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        if (idx > 0) {
            CGFloat y = _lineScrollView.frame.size.height-60 - lineWidth/2.0 - ([obj floatValue] * scale);
            [path addLineToPoint:CGPointMake(space*(idx+1), y)];
        }
    }];
    lineLayer.path = path.CGPath;
    [self.lineScrollView.layer addSublayer:lineLayer];
    [lineLayer addAnimation:self.animation forKey:@"lineStrokeEndAnimation"];
    
}

//把点标出来
- (void)drawPoint:(NSArray *)array {
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        CGFloat y = _lineScrollView.frame.size.height - 60 - lineWidth/2.0 - [obj floatValue]*scale;
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(space * (idx+1), y) radius:radius startAngle:0 endAngle:(M_PI)*2 clockwise:YES];
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.fillColor = [UIColor orangeColor].CGColor;
        circleLayer.strokeColor = [UIColor clearColor].CGColor;
        circleLayer.path = circlePath.CGPath;
        
        [_lineScrollView.layer addSublayer:circleLayer];
        
    }];
    
}

//添加坐标轴
- (void)addxyAxis {
    self.xAxis = [self lineWithStartPoint:CGPointMake(distance, selfH-30) breakPoint:CGPointMake(kDeviceWidth-distance, selfH-30) endPoint:CGPointMake(kDeviceWidth-distance-cornerW, selfH-30-cornerW)];
    self.yAxis = [self lineWithStartPoint:CGPointMake(distance+lineWidth/2.0, selfH-30) breakPoint:CGPointMake(distance, 30) endPoint:CGPointMake(distance+cornerW, 30+cornerW)];
    
    [self.layer addSublayer:self.xAxis];
    [self.layer addSublayer:self.yAxis];
}

//画坐标轴
- (CAShapeLayer *)lineWithStartPoint:(CGPoint)startPoint breakPoint:(CGPoint)breakPoint endPoint:(CGPoint)endPoint {
    CAShapeLayer *line = [CAShapeLayer layer];
    line.fillColor = [UIColor clearColor].CGColor;
    line.strokeColor = [UIColor blackColor].CGColor;
    line.lineWidth = 1.0;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:breakPoint];
    [linePath addLineToPoint:endPoint];
    line.path = linePath.CGPath;
    
    [line addAnimation:self.animation forKey:@"xyLineStrokeEndAnimation"];
    return line;
}

- (UIScrollView *)lineScrollView {
    if (_lineScrollView == nil) {
        _lineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance+lineWidth, 30, kDeviceWidth-distance*2-lineWidth, selfH-60-lineWidth/2.0)];
        _lineScrollView.bounces = NO;
        _lineScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _lineScrollView;
}

- (CABasicAnimation *)animation {
    if (_animation == nil) {
        _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.fromValue = @0.0;
        _animation.toValue = @1.0;
        _animation.duration = 2.0;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    return _animation;
}


@end
