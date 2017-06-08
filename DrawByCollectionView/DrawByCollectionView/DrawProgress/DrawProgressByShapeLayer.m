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
//        [self setBackgroundColor:[UIColor grayColor]];
        [self setBackgroundColor:[UIColor colorWithRed:(255)/255.0 green:(156)/255.0 blue:(14)/255.0 alpha:1.0]];
        self.fromValue = 0;
        self.toValue = 0.99;
        self.currentProgress = 0.99;
        [self.label setText:[NSString stringWithFormat:@"%.2f%%",self.currentProgress * 100]];
        [self draw];
        [self draw2];
        
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
        
        CGPoint center = CGPointMake(100, 100);
        CGFloat radius = 62.5;
        CGFloat startA = -M_PI_2;
        CGFloat endA = -M_PI_2 +  M_PI * 2;
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        shapeLayer.path = path.CGPath;
        
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 5.0f;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

- (void)draw {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    
    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 62.5;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 -  M_PI * 2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 13.0f;
    shapeLayer.lineCap = kCALineCapButt;
    UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:0.4];
    shapeLayer.strokeColor = color.CGColor;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)draw2 {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    
    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 62.5;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 -  M_PI * 2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5.0f;
    shapeLayer.lineCap = kCALineCapButt;
    UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:0.4];
    shapeLayer.strokeColor = color.CGColor;
    
    [self.layer addSublayer:shapeLayer];
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
