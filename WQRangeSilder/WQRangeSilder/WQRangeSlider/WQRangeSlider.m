//
//  WQRangeSlider.m
//  WQRangeSilder
//
//  Created by hwq on 2018/9/6.
//  Copyright © 2018年 hwq. All rights reserved.
//

#import "WQRangeSlider.h"
#import "UIImage+Extension.h"
#import "Masonry.h"

#define ThumImageWidth 28.0
#define BgForeViewHeight 5
#define BgForeViewWidth SliderWidth - ThumImageWidth

#define SliderWidth self.frame.size.width
#define SliderHeight self.frame.size.height

@interface WQRangeSlider()
{
    CGFloat leftCenterX;
    CGFloat rightCenterX;

}

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *foreView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation WQRangeSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      // self.backgroundColor = UIColor.redColor;
        [self addSubview:self.bgView];
        [self addSubview:self.foreView];
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];

        self.minValue = 0;
        self.maxValue = 100;
        self.lowerValue = 0;
        self.upperValue = 100;
        
    }
    return self;
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
      //  self.backgroundColor = UIColor.redColor;
        [self addSubview:self.bgView];
        [self addSubview:self.foreView];
        [self addSubview:self.leftImageView];
        [self addSubview:self.rightImageView];
        
        self.minValue = 0;
        self.maxValue = 100;
        self.lowerValue = 0;
        self.upperValue = 100;
    }
    return  self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(ThumImageWidth/2, SliderHeight/2-2.5, SliderWidth - ThumImageWidth, 5);
    
   // self.foreView.frame = CGRectMake(ThumImageWidth/2, SliderHeight/2-2.5, SliderWidth - ThumImageWidth , 5);
    [self.foreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(ThumImageWidth/2);
        make.right.equalTo(self).offset(-ThumImageWidth/2);
        make.height.mas_equalTo(BgForeViewHeight);
        make.centerY.equalTo(self);
    }];
    self.leftImageView.frame = CGRectMake(0, SliderHeight/2-ThumImageWidth/2,  ThumImageWidth , ThumImageWidth);
    self.rightImageView.frame = CGRectMake(SliderWidth-ThumImageWidth, SliderHeight/2-ThumImageWidth/2,  ThumImageWidth , ThumImageWidth);
    
    leftCenterX = self.leftImageView.center.x;
    rightCenterX = self.rightImageView.center.x;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius = 2;
        _bgView.backgroundColor = UIColor.lightGrayColor;
    }
    return _bgView;
}
- (UIView *)foreView {
    if (!_foreView) {
        _foreView = [[UIView alloc]init];
        _foreView.layer.cornerRadius = 2;
        _foreView.backgroundColor = UIColor.blueColor;
    }
    return _foreView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.image = [UIImage imageNamed:@"SliderThumb-Highlighted.png"];
        _leftImageView.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftpanView:)];
        
        [_leftImageView addGestureRecognizer:pan];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.image = [UIImage imageNamed:@"SliderThumb-Highlighted.png"];
        _rightImageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightpanView:)];
        
        [_rightImageView addGestureRecognizer:pan];
    }
    return _rightImageView;
}

#pragma mark pan   平移手势事件
-(void)leftpanView:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self];
 //   NSLog(@"%f,%f", sender.view.frame.origin.x,sender.view.frame.origin.y);
    //保证left不会不会往左移动过多，也不会超过right位置。
    CGFloat x = sender.view.center.x + point.x;

    if ( x > leftCenterX && x < self.rightImageView.center.x) {
        //更新坐标
        sender.view.center=CGPointMake(x, sender.view.center.y);
        CGRect frame = self.foreView.frame;
        self.foreView.frame = CGRectMake(x, frame.origin.y, self.rightImageView.center.x - sender.view.center.x, BgForeViewHeight);
        
        CGFloat temp = sender.view.center.x - self.bgView.frame.origin.x;
        CGFloat width = BgForeViewWidth;
        CGFloat ratio = temp / width;
        
        self.lowerValue = (_maxValue - _minValue) * ratio;
        if (self.block) {
            self.block();
        }
       // NSLog(@"%.0f,%.0f", self.lowerValue,self.upperValue);
    }
   
    //增量置为o
    [sender setTranslation:CGPointZero inView:sender.view];
    
}
- (void)test{
    CGRect frame = self.foreView.frame;
    self.foreView.frame = CGRectMake(self.leftImageView.center.x, frame.origin.y, frame.size.width- (self.leftImageView.frame.origin.x - frame.origin.x), BgForeViewHeight);
}
-(void)rightpanView:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self];
    NSLog(@"%f,%f", sender.view.frame.origin.x,sender.view.frame.origin.y);
     //保证right不会不会往右移动过多，也不会超过left位置。
    CGFloat x = sender.view.center.x + point.x;
    if ( x <= rightCenterX && x >= self.leftImageView.center.x) {
        sender.view.center=CGPointMake(x, sender.view.center.y);
        CGRect frame = self.foreView.frame;
        self.foreView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+point.x, BgForeViewHeight);
        
        CGFloat temp = sender.view.center.x - self.bgView.frame.origin.x;
        CGFloat width = BgForeViewWidth;
        CGFloat ratio = temp / width;
        
        self.upperValue =(_maxValue - _minValue) * ratio ;
        if (self.block) {
            self.block();
        }
       // NSLog(@"%.0f,%.0f", self.lowerValue,self.upperValue);
    }
    
    //增量置为o
    [sender setTranslation:CGPointZero inView:sender.view];

    
}

@end
