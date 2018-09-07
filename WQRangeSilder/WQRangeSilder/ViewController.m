//
//  ViewController.m
//  WQRangeSilder
//
//  Created by hwq on 2018/9/6.
//  Copyright © 2018年 hwq. All rights reserved.
//

#import "ViewController.h"
#import "WQRangeSlider.h"
#import "Masonry.h"


@interface ViewController ()

@property (nonatomic, strong)WQRangeSlider *wqSlider;

@property (weak, nonatomic) IBOutlet WQRangeSlider *sdSlider;




@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _wqSlider = [[WQRangeSlider alloc]init];
    //_wqSlider = [[WQRangeSlider alloc]initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 100, 5)];
   
    __weak typeof(self)weakSelf = self;
    _wqSlider.block = ^{
        NSLog(@"%f,%f",weakSelf.wqSlider.lowerValue, weakSelf.wqSlider.upperValue);
    };
    [self.view addSubview:_wqSlider];
    [_wqSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.mas_offset(100);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(200);
    }];
    
}





@end
