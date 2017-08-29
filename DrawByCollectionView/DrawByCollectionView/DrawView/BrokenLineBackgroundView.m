//  ************************************************************************
//
//  BrokenLineBackgroundView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/8/26.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "BrokenLineBackgroundView.h"
#import "DrawConfig.h"

#define INTERVAL_TEXT_LEFT_MARGIN 10.0
#define INTERVAL_TEXT_MAX_WIDTH 100.0

@interface BrokenLineBackgroundView ()

@property (nonatomic, strong) DrawConfig *drawConfig;

@end

@implementation BrokenLineBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setContentMode:UIViewContentModeRedraw];
    }
    return self;
}

+ (instancetype)lineBackgroundViewWithFrame:(CGRect)frame withDrawConfig:(DrawConfig *)drawConfig {
    BrokenLineBackgroundView *lineBackgroundView = [[self alloc] initWithFrame:frame];
    lineBackgroundView.drawConfig = drawConfig;
    return lineBackgroundView;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *boundsPath = [UIBezierPath bezierPathWithRect:self.bounds];
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    [boundsPath fill];
    
    CGFloat maxHeight = [self viewHeight];
    [[UIColor redColor]setStroke];
    UIBezierPath *gridLinePath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(35.0,CGRectGetHeight([self frame]) - 25);
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetHeight([self frame]) - 25);
    [gridLinePath moveToPoint:startPoint];
    [gridLinePath addLineToPoint:endPoint];
    [gridLinePath setLineWidth:1.0];
    
    CGContextSaveGState(context);
    
    NSUInteger numberOfIntervalLines =  5;//[self.chartContainer numberOfIntervalLines];
    CGFloat intervalSpacing = (maxHeight/(numberOfIntervalLines-1));
    
    CGFloat maxIntervalValue = 100;//[self.chartContainer maxValue];
    CGFloat minIntervalValue = 0;//[self.chartContainer minValue];
    CGFloat maxIntervalDiff = (maxIntervalValue - minIntervalValue) / (numberOfIntervalLines-1);
    
    for(NSUInteger i = 0;i<numberOfIntervalLines;i++) {
        [self.drawConfig.backVeiwLineColor setStroke];
        [gridLinePath stroke];
        NSString *stringToDraw = [NSString stringWithFormat:@"%.f",0 + i * maxIntervalDiff];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [stringToDraw drawInRect:CGRectMake(INTERVAL_TEXT_LEFT_MARGIN,
                                            (CGRectGetHeight([self frame]) - 20 - [[UIFont systemFontOfSize:16] lineHeight]),
                                            INTERVAL_TEXT_MAX_WIDTH, [[UIFont systemFontOfSize:16] lineHeight])
                  withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                   NSForegroundColorAttributeName: self.drawConfig.backVeiwTextColor,
                                   NSParagraphStyleAttributeName: paragraphStyle
                                   }];
        
        
        CGContextTranslateCTM(context, 0.0, - intervalSpacing);
    }
    
    CGContextRestoreGState(context);
}

- (CGFloat)viewHeight{
    UIFont *font = [UIFont systemFontOfSize:16];
    CGFloat maxHeight = round(CGRectGetHeight([self frame]) - [font lineHeight] - 23);
    return maxHeight;
}

@end
