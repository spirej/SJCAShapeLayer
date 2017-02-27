//
//  SJBarChart.m
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/23.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#import "SJBarChart.h"

static CGFloat const lineWidth  = 1.0;      //坐标轴线宽
static CGFloat const distance   = 20.0;     //距屏幕边距
static CGFloat const cornerW    = 10.0f;    //拐角长度
static CGFloat const barWidth   = 50.0f;    //柱状宽度
static CGFloat const space      = 30.0f;    //柱状之间的间隔
static CGFloat const scale      = 3.0f;     //柱状显示高度计算比例 *scale

@interface SJBarChart ()
{
    CGFloat selfW, selfH;
    NSArray *source;
}
@property (nonatomic, strong) CAShapeLayer *xAxis;
@property (nonatomic, strong) CAShapeLayer *yAxis;
@property (nonatomic, strong) UIScrollView *barScrollView;
@property (nonatomic, strong) CABasicAnimation *animation;
@end

@implementation SJBarChart

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

- (void)showBarChart:(NSArray *)sourceArray {
    source = sourceArray;
    [self addxyAxis];
    [self addSubview:self.barScrollView];
    _barScrollView.contentSize = CGSizeMake(sourceArray.count*(space+barWidth) + space, 0);
    
    [sourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *bar = [self drawBar:idx];
        [_barScrollView.layer addSublayer:bar];
    }];

}

//柱状图
- (CAShapeLayer *)drawBar:(NSInteger)index {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = barWidth;
    
    //终点y
    CGFloat y = _barScrollView.frame.size.height-60 - lineWidth/2.0 - ([[source objectAtIndex:index] floatValue] * scale);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake((space + barWidth)*index + (space+barWidth/2.0), _barScrollView.frame.size.height-60)];
    [path addLineToPoint:CGPointMake((space + barWidth)*index + (space+barWidth/2.0), y)];
    layer.path = path.CGPath;
    
    [layer addAnimation:self.animation forKey:nil];
    return layer;
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

- (UIScrollView *)barScrollView {
    if (_barScrollView == nil) {
        _barScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance+lineWidth, 30, kDeviceWidth-distance*2-lineWidth-cornerW, selfH-60-lineWidth/2.0)];
        _barScrollView.bounces = NO;
        _barScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _barScrollView;
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
