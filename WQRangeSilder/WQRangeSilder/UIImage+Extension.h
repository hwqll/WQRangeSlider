//
//  UIImage+Extension.h
//  ShengJiaMeng
//
//  Created by hwq on 2018/8/31.
//  Copyright © 2018年 hwq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 * @brief 根据给定的颜色创建一张图片
 * @param color 颜色
 * @return 图片
*/
+ (UIImage *)createImageWithColor:(UIColor*) color;
@end
