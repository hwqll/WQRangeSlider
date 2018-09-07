//
//  WQRangeSlider.h
//  WQRangeSilder
//
//  Created by hwq on 2018/9/6.
//  Copyright © 2018年 hwq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShowValueBlock) (void);

typedef NS_ENUM(NSUInteger, TrackImageStyle) {
    TrackImageStyleColor,
    TrackImageStyleImage
};

@interface WQRangeSlider : UIView

@property (nonatomic, assign) CGFloat lowerValue; //左值
@property (nonatomic, assign) CGFloat upperValue; //右值

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, copy) ShowValueBlock block; //传递两个值出去。

//- (void)setNormalThumImage:(NSString *)normalThumImageStr highlightThumImage:(NSString *)highlightThumImageStr minimumTrackImage: (NSString *)minimumTrackImageStr maximumTrackImage: (NSString *)maximumTrackImageStr trackImageStyle:(TrackImageStyle)imageStyle;

@end
