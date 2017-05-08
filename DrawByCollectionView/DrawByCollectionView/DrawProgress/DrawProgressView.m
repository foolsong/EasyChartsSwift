//
//  DrawProgressView.m
//  DrawByCollectionView
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "DrawProgressView.h"

@interface DrawProgressView()

@property (nonatomic, weak) UILabel *label;

@property (nonatomic, assign) NSInteger progress;
@property (nonatomic, assign) NSInteger lastProgress;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat offest;


//test
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation DrawProgressView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        self.index = 0;
        _progress = 60;
        _lastProgress = _progress;
        [self setupProgress:_lastProgress];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.timer) {
        return;
    }
    self.index = 0;
    NSInteger newProgress = [self createProgress];
    self.offest = (newProgress - self.progress) / 10;
//    self.lastProgress = self.progress;
    self.progress = newProgress;
    [self setupTimer];
    
}

- (NSInteger)createProgress {
    return arc4random_uniform(100);
}

- (void)setupTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (CGFloat)timeInterval {
    if (self.offest < 2 && self.offest > -2) {
        return 0.1;
    } if (self.offest < 5 && self.offest > -5) {
        return 0.1;
    } else {
        return 0.02;
    }
}

- (void)timerAction {
    self.index ++;
    
    if (self.index == 10) {
        [self.timer invalidate];
        self.timer = nil;
        self.lastProgress = self.progress;
        [self setupProgress:self.progress];
    } else {
        self.lastProgress += self.offest;
        [self setupProgress:self.lastProgress];
    }
   
}

- (UILabel *)label {
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)setupProgress:(NSInteger)progress
{
//    _progress = progress;
    self.label.text = [NSString stringWithFormat:@"%ld%%",progress];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    
    
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 50 - 2;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 - (_lastProgress / 100.0) * M_PI * 2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:NO];
    
    self.progressLayer.path = [path CGPath];
    [self.layer addSublayer:self.progressLayer];
    
//    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
//    CGContextSetLineWidth(ctx, 6.0);
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
    
//    CGContextDrawPath(context, kCGPathFillStroke);
}

- (CAShapeLayer *)progressLayer {
    if (_progressLayer == nil) {
        _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
        _progressLayer.strokeColor = [[UIColor orangeColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
        _progressLayer.opacity = 1; //背景颜色的透明度
        _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
        _progressLayer.lineWidth = 10;//线的宽度
        
    }
    return _progressLayer;
}
@end
