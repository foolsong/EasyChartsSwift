//  ************************************************************************
//
//  DrawLineBackgroundView.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/6/6.
//  Copyright © 2017年 宋永建. All rights reserved.
//
//  Main function:
//
//  Other specifications:
//
//  ************************************************************************

#import "DrawLineBackgroundView.h"

@interface DrawLineBackgroundView ()


@end

@implementation DrawLineBackgroundView

+ (instancetype)backgroundView {
    DrawLineBackgroundView *view = [[self alloc] init];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 210);
    return view;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configOwnProperties];
        [self setupBackGroupImageView];
    }
    return self;
}

- (void)setupBackGroupImageView {
    UIImage *backGroupImage = [UIImage imageNamed:@"lineBackground"];
    UIImageView *backGroupImageView = [[UIImageView alloc] init];
    backGroupImageView.image = backGroupImage;
    backGroupImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, backGroupImage.size.height);
    [self addSubview:backGroupImageView];
}

- (void)configOwnProperties {
    [self setBackgroundColor:[UIColor colorWithRed:(255)/255.0 green:(156)/255.0 blue:(14)/255.0 alpha:1.0]];
}

@end
