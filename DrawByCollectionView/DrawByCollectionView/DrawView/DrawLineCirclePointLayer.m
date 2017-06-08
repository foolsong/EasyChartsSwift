//  ************************************************************************
//
//  DrawLineCirclePointLayer.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/8.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineCirclePointLayer.h"
#import <UIKit/UIKit.h>

#define CIRCLE_SIZE 7.0

@interface DrawLineCirclePointLayer ()

@property (nonatomic, strong) UIImage *circleImage;

@end

@implementation DrawLineCirclePointLayer

+ (instancetype)circlePointLayer {
        DrawLineCirclePointLayer *circleLayer = [self layer];
        UIImage *img = [self circleImage];
        [circleLayer setContents:(id)img.CGImage];
        [circleLayer setFrame:CGRectMake(0,0, img.size.width, img.size.height)];
        [circleLayer setGeometryFlipped:YES];
        [circleLayer setLineJoin:kCALineJoinBevel];
        circleLayer = circleLayer;
        

    return circleLayer;
}

+ (UIImage *)circleImage{
//    if(!_circleImage){
    UIImage *circleImage;
        CGSize imageSize = CGSizeMake(CIRCLE_SIZE, CIRCLE_SIZE);
        CGFloat strokeWidth = 1.5;
        
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);//[UIImage imageNamed:@"circle"];
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [[UIColor clearColor] setFill];
        CGContextFillRect(context, (CGRect){CGPointZero, imageSize});
        
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: (CGRect){CGPointMake(strokeWidth/2.0, strokeWidth/2.0),
            CGSizeMake(CIRCLE_SIZE-strokeWidth, CIRCLE_SIZE-strokeWidth)}];
        
        CGContextSaveGState(context);
        //yjSong 圆圈填充
        UIColor *color = [UIColor colorWithRed:(255)/255.0 green:(209)/255.0 blue:(93)/255.0 alpha:1.0];
        [color setFill];
        
        [ovalPath fill];
        CGContextRestoreGState(context);
        
        //yjSong 圆圈边框
        [[UIColor whiteColor] setStroke];
        [ovalPath setLineWidth:strokeWidth];
        [ovalPath stroke];
        
        circleImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//    }
    return circleImage;
}

@end
