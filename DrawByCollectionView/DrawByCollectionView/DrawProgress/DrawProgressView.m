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

- (UILabel *)label
{
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


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGPoint center = CGPointMake(100, 100);
    CGFloat radius = 50 - 2;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + (_lastProgress / 100.0) * M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(ctx, 6.0);
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    
}

@end
