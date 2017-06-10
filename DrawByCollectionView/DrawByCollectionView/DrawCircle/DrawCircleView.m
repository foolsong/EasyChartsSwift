//
//  DrawCircleView.m
//  DrawByCollectionView
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "DrawCircleView.h"
#import "DrawCircleModel.h"

@interface DrawCircleView()

@property (nonatomic, copy) NSArray *circleModelList;

@end

@implementation DrawCircleView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
//        self.fromValue = 0;
//        self.toValue = 0;
//        self.currentProgress = 0;
//        [self drawBackGroupCircle];
//        [self drawBackGroupCircle2];
//        [self drawBackGroupCircle4];
//        [self drawBackGroupCircle3];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

#pragma mark - function
- (void)resetCircleList:(NSArray *)circleModelList {
    self.circleModelList = circleModelList;
    for (DrawCircleModel *model in self.circleModelList) {
        [self drawBackGroupCircle:model];
    }
}

#pragma mark - subviewsDrawCircleModel
- (void)drawBackGroupCircle:(DrawCircleModel *)model {
    
//    UIColor *circleColor = [UIColor colorWithRed:(64)/255.0 green:(186)/255.0 blue:(255)/255.0 alpha:1];
    [self drawCircleWithLineWidth:5.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:0.4]
                           radius:35
                           startA:model.startAngle
                             endA:model.endAngle];
    [self drawCircleWithLineWidth:39.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:1]
                           radius:57
                           startA:model.startAngle
                             endA:model.endAngle];
    [self drawCircleWithLineWidth:5.0f
                        lineColor:[model.circleColor colorWithAlphaComponent:0.2]
                           radius:79
                           startA:model.startAngle
                             endA:model.endAngle];
}

//- (void)drawBackGroupCircle2 {
//    UIColor *circle1Color = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:0.4];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle1Color
//                           radius:35
//                           startA:-M_PI_2 + M_PI * 0.5];
//    
//    UIColor *circle2Color = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:1.0];
//    [self drawCircleWithLineWidth:39.0f
//                        lineColor:circle2Color
//                           radius:57
//                           startA:-M_PI_2 + M_PI * 0.5];
//    
//    UIColor *circle3Color = [UIColor colorWithRed:(255)/255.0 green:(133)/255.0 blue:(155)/255.0 alpha:0.2];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle3Color
//                           radius:79
//                           startA:-M_PI_2 + M_PI * 0.5];
//}
//
//- (void)drawBackGroupCircle3 {
//    UIColor *circle1Color = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:0.4];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle1Color
//                           radius:35
//                           startA:-M_PI_2 + M_PI * 1];
//    
//    UIColor *circle2Color = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:1.0];
//    [self drawCircleWithLineWidth:39.0f
//                        lineColor:circle2Color
//                           radius:57
//                           startA:-M_PI_2 + M_PI * 1];
//    
//    UIColor *circle3Color = [UIColor colorWithRed:(255)/255.0 green:(179)/255.0 blue:(0)/255.0 alpha:0.2];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle3Color
//                           radius:79
//                           startA:-M_PI_2 + M_PI * 1];
//}
//
//- (void)drawBackGroupCircle4 {
//    UIColor *circle1Color = [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:0.4];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle1Color
//                           radius:35
//                           startA:-M_PI_2 + M_PI * 1.5];
//    
//    UIColor *circle2Color = [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:1.0];
//    [self drawCircleWithLineWidth:39.0f
//                        lineColor:circle2Color
//                           radius:57
//                           startA:-M_PI_2 + M_PI * 1.5];
//    
//    UIColor *circle3Color = [UIColor colorWithRed:(152)/255.0 green:(230)/255.0 blue:(123)/255.0 alpha:0.2];
//    [self drawCircleWithLineWidth:5.0f
//                        lineColor:circle3Color
//                           radius:79
//                           startA:-M_PI_2 + M_PI * 1.5];
//}

- (CAShapeLayer *)drawCircleWithLineWidth:(CGFloat )lineWidth
                                lineColor:(UIColor *)color
                                   radius:(CGFloat ) radius
                                   startA:(CGFloat ) startA
                                     endA:(CGFloat ) endA{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

#pragma mark - LazyLoads


- (NSArray *)circleModelList {
    if (_circleModelList == nil) {
        _circleModelList = @[];
    }
    return _circleModelList;
}


@end
