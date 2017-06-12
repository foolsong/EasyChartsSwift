//
//  DrawCircleView.m
//  DrawByCollectionView
//
//  Created by yjsong on 17/5/7.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "DrawCircleView.h"
#import "DrawCircleModel.h"
#import "DrawLineCirclePointLayer.h"

@interface DrawCircleView()

@property (nonatomic, copy) NSArray *circleModelList;
@property (nonatomic, strong) NSMutableArray *layerMutableArray;

@end

@implementation DrawCircleView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

#pragma mark - function
- (void)resetCircleList:(NSArray *)circleModelList {
    [self clearLayerMutableArray];
    self.circleModelList = circleModelList;
    for (DrawCircleModel *model in self.circleModelList) {
        [self drawBackGroupCircle:model];
        [self testAddPoint:model];
    }
}

- (void)clearLayerMutableArray {
    for (CAShapeLayer *shapeLayer in self.layerMutableArray) {
        [shapeLayer removeFromSuperlayer];
    }
    
    [self.layerMutableArray removeAllObjects];
}

#pragma mark - subviewsDrawCircleModel
- (void)drawBackGroupCircle:(DrawCircleModel *)model {
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
    [self.layerMutableArray addObject:shapeLayer];
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

- (void)testAddPoint:(DrawCircleModel *)model {
    if (model.offestX <= 0) {
        return;
    }
    DrawLineCirclePointLayer *layer = [DrawLineCirclePointLayer circlePointLayer];
    CGRect frame = layer.frame;
    frame.origin.x = model.offestX - 4.25;
    frame.origin.y = model.offestY - 4.25;
    layer.frame = frame;
    [self.layer addSublayer:layer];
}

#pragma mark - LazyLoads
- (NSArray *)circleModelList {
    if (_circleModelList == nil) {
        _circleModelList = @[];
    }
    return _circleModelList;
}

-(NSMutableArray *)layerMutableArray {
    if (_layerMutableArray == nil) {
        _layerMutableArray = [NSMutableArray array];
    }
    return _layerMutableArray;
}
@end
