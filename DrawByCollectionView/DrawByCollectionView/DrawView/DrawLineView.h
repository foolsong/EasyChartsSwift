//
//  DrawLineView.h
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineView : UIView

+ (instancetype)lineViewWithFrame:(CGRect) frame;


+ (instancetype)lineView2WithFrame:(CGRect) frame;

/**
 重新设置图标的数据

 @param pointValueList 展示数据的数组
 @param titleTextList 对应的title数组
 */
- (void)reloadLineViewDataWithPointValveList:(NSArray *)pointValueList
                                   titleText:(NSArray *)titleTextList;

@end
