//
//  PointViewModel.h
//  DrawByCollectionView
//
//  Created by yjsong on 17/4/30.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LineType) {
    LineTypeNormal = 0,
    LineTypeDotted,
    LineTypeNoline
};

@interface PointViewModel : NSObject

@property(nonatomic, assign) LineType leftLineType;
@property(nonatomic, assign) LineType rightLineType;

@property (nonatomic, copy) NSString *pointY;

//@property(nonatomic, assign) CGPoint leftPoint;
//@property(nonatomic, assign) CGPoint middlePoint;
//@property(nonatomic, assign) CGPoint rightPoint;

@end
