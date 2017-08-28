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

#define INTERVAL_TEXT_LEFT_MARGIN 10.0
#define INTERVAL_TEXT_MAX_WIDTH 100.0

@interface BrokenLineBackgroundView ()


@end

@implementation BrokenLineBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setContentMode:UIViewContentModeRedraw];
//        [self setChartContainer:chartContainer];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    NSAssert(NO, @"Use initWithFrame:chartContainer:");
//    return [self initWithFrame:frame chartContainer:nil];
//}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *boundsPath = [UIBezierPath bezierPathWithRect:self.bounds];
    //yjSong   背景色
//    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:52.0/255.0
//                                                             green:61.0/255.0
//                                                              blue:75.0/255.0
//                                                             alpha:1.0] CGColor]);
        CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
    [boundsPath fill];
    
    CGFloat maxHeight = [self viewHeight];
    
    //  [[UIColor colorWithRed:0.329 green:0.322 blue:0.620 alpha:1.000] setStroke];
    [[UIColor redColor]setStroke];
    UIBezierPath *gridLinePath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(50.0,CGRectGetHeight([self frame]) - 25);
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
        [[UIColor colorWithRed:52.0/255.0
                          green:61.0/255.0
                           blue:75.0/255.0
                          alpha:1.0] setStroke];
        [gridLinePath stroke];
        NSString *stringToDraw = [NSString stringWithFormat:@"%.f",0 + i * maxIntervalDiff];
        UIColor *stringColor = [UIColor colorWithRed:52.0/255.0
                                               green:61.0/255.0
                                                blue:75.0/255.0
                                               alpha:1.0];//[self.chartContainer gridIntervalFontColor];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [stringToDraw drawInRect:CGRectMake(INTERVAL_TEXT_LEFT_MARGIN,
                                            (CGRectGetHeight([self frame]) - 20 - [[UIFont systemFontOfSize:16] lineHeight]),
                                            INTERVAL_TEXT_MAX_WIDTH, [[UIFont systemFontOfSize:16] lineHeight])
                  withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16],
                                   NSForegroundColorAttributeName: stringColor,
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
