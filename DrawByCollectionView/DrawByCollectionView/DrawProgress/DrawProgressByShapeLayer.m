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

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UILabel *label;

@end

@implementation DrawProgressByShapeLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        self.fromValue = 0;
        self.toValue = 0.99;
        self.currentProgress = 0.99;
        [self.label setText:[NSString stringWithFormat:@"%.2f%%",self.currentProgress * 100]];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 0.4f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:self.fromValue];
    pathAnima.toValue = [NSNumber numberWithFloat:self.toValue];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat progress = [self createProgress];

    self.fromValue =  _currentProgress ;
    self.toValue = progress;

    self.currentProgress = progress;
    
    [self.label setText:[NSString stringWithFormat:@"%.2f%%",self.currentProgress * 100]];
    
    [self setNeedsDisplay];
}

- (CGFloat)createProgress {
    return arc4random_uniform(100) / 100.0;
}

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        
        CGRect frame = CGRectMake(25, 25, 150, 150);
        
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
        
        
        CGPoint center = CGPointMake(100, 100);
        CGFloat radius = 50 - 2;
        CGFloat startA = -M_PI_2;
        CGFloat endA = -M_PI_2 -  M_PI * 2;
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
        
        
        
        
        shapeLayer.path = path.CGPath;
        
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 10.0f;
        shapeLayer.lineCap = kCALineCapButt;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//        label.center = self.center;
//        [label setBackgroundColor:[UIColor redColor]];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

@end
