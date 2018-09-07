#  双向滑块

使用方式：
    一、纯代码
    支持frame布局和代码布局。
    
    _wqSlider = [[WQRangeSlider alloc]init];
    //_wqSlider = [[WQRangeSlider alloc]initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 100, 5)];
    [_wqSlider setNormalThumImage:@"SliderThumb-Normal" highlightThumImage:@"SliderThumb-Highlighted" minimumTrackImage:nil maximumTrackImage:nil trackImageStyle:TrackImageStyleColor];
    _wqSlider.maxValue = 100;
    _wqSlider.minValue = 0;
    
    __weak typeof(self)weakSelf = self;
    _wqSlider.block = ^{
    NSLog(@"%f,%f",weakSelf.wqSlider.lowerValue, weakSelf.wqSlider.upperValue);
    };
    [self.view addSubview:_wqSlider];
    [_wqSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(20);
    make.top.mas_offset(100);
    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 100);
    make.height.mas_equalTo(5);
    }];
    
    二、storyboard
    设置view的class为WQRangeSlider。
