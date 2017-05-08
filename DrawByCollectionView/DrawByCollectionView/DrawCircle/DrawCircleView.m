//
//  DrawCircleView.m
//  DrawByCollectionView
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "DrawCircleView.h"

static inline float radians(double degrees) {
    return degrees *  M_PI/ 180.f;
}

@interface DrawCircleView()

@property(nonatomic, assign)CGFloat circularRingRadius;

@property(nonatomic, copy)NSArray *degreeArray;
@property(nonatomic, copy)NSArray *colorArray;

@property(nonatomic, assign)BOOL isShowSeperate;
@end

@implementation DrawCircleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isShowSeperate = YES;
        [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self draw1];
}

- (void)draw2 {
    
    NSInteger allCount = 4;
    
    
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置半径
    CGFloat radius=100.f;
    if (self.circularRingRadius==0) {
        self.circularRingRadius=54.f;
    }
    CGFloat intRadius=radius-self.circularRingRadius;
    //设置圆心的坐标
    CGFloat centerX=self.bounds.size.width/2.f;
    CGFloat centerY=self.bounds.size.height/2.f;
    //设置起始角度
    CGFloat pieStart=90.f;
    //设置旋转方向
    int clockwise=0; //1: 顺时针 ; 0:逆时针
    //画扇形
    if(allCount == 0){  //无资产
        CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
        CGContextMoveToPoint(context, centerX, centerY);
        CGContextAddArc(context, centerX, centerY, radius,radians(0), radians(360), clockwise);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }else{
        for (int i=0; i<self.degreeArray.count; i++) {
            CGFloat end=pieStart+[self.degreeArray[i] doubleValue];
            if (self.isShowSeperate) {
                if(i%2==0){  //分割线
                    UIColor *fillColor=self.colorArray[(int)(i/2)];
                    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
                }else{
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                }
            }else{
                CGContextSetFillColorWithColor(context, [self.colorArray[i] CGColor]);
            }
            NSLog(@"%f",radians(end));
            CGContextMoveToPoint(context, centerX, centerY);
            CGContextAddArc(context, centerX, centerY, radius,radians(pieStart), radians(end), clockwise);
            CGContextClosePath(context);
            CGContextFillPath(context);
            pieStart+=[self.degreeArray[i] doubleValue];
        }
    }
    //画内圆
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddArc(context, centerX, centerY, intRadius, 0, radians(360.f), 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

- (NSArray *)degreeArray {
    return @[@"112",@"2",@"110",@"2",@"30",@"2",@"100",@"2"];
}

- (NSArray *)colorArray {
    return @[[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor brownColor]];
}

- (void)draw1 {
    CGFloat w = self.bounds.size.width * 0.5;
    CGFloat h = self.bounds.size.height * 0.5 ;
    
    NSArray *array = @[@25,@30,@45];
    NSArray *colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor yellowColor]];
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(w * 0.7, h * 0.9);
    CGFloat radius = w * 0.5 - 5;
    
    CGFloat startA = 0;
    CGFloat endA = 0;
    //扫过角度范围
    CGFloat angle = 0;
    
    for (int i = 0; i < array.count; i ++) {
        
        startA = endA;
        angle = [array[i] integerValue] / 100.0 * M_PI * 2;
        endA = startA + angle;
        
        //弧形路径
        //clockwise: 是否是按照时钟的方向旋转(是否顺时针)
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        [(UIColor *)colorArray[i] set];
        
        CGContextAddPath(ctx, path.CGPath);
        CGContextFillPath(ctx);
    }
}
@end
