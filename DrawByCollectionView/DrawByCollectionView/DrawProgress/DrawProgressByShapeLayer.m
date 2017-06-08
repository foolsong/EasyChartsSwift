//  ************************************************************************
//
//  DrawProgressByShapeLayer.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/5/8.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawProgressByShapeLayer.h"

@interface DrawProgressByShapeLayer ()

@property (nonatomic, assign) CGFloat currentProgress;

@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;

@property (nonatomic, strong) CAShapeLayer *progresShapeLayer;

@property (nonatomic, strong) UILabel *label;

@end

@implementation DrawProgressByShapeLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:(255)/255.0 green:(156)/255.0 blue:(14)/255.0 alpha:1.0]];
        self.fromValue = 0;
        self.toValue = 0;
        self.currentProgress = 0;
        [self.label setText:[NSString stringWithFormat:@"%.2f%%",self.currentProgress * 100]];
        [self drawBackGroupCircle];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self animationChangeProgress];
}

#pragma mark - function
- (void)animationChangeProgress {
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 0.4f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:self.fromValue];
    pathAnima.toValue = [NSNumber numberWithFloat:self.toValue];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progresShapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)resetProgress:(CGFloat)progress {
    self.fromValue =  _currentProgress ;
    self.toValue = progress;
    self.currentProgress = progress;
    
    [self.label setText:[NSString stringWithFormat:@"%.2f%%",self.currentProgress * 100]];
    
    [self setNeedsDisplay];
    
}

#pragma mark - subviews
- (void)drawBackGroupCircle {
    UIColor *backGroupColor = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:0.4];
    [self drawCircleWithLineWidth:13.0f lineColor:backGroupColor];
    
    UIColor *backLinecolor = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:1.0];
    [self drawCircleWithLineWidth:5.0f lineColor:backLinecolor];
}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat)lineWidth lineColor:(UIColor *)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 62.5;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 +  M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

#pragma mark - LazyLoads
- (CAShapeLayer *)progresShapeLayer {
    if (_progresShapeLayer == nil) {
        _progresShapeLayer = [self drawCircleWithLineWidth:5.0f
                                                 lineColor:[UIColor whiteColor]];;
    }
    return _progresShapeLayer;
}

- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];;
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

@end
