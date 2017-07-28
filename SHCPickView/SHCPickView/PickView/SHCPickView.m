//
//  SHCPickView.m
//  SHCPickView
//
//  Created by gcct on 2017/7/26.
//  Copyright © 2017年 sunhaichen. All rights reserved.
//
#define shc_screenHeight ([UIScreen mainScreen].bounds.size.height)
#define shc_screenWidth ([UIScreen mainScreen].bounds.size.width)
#define SHC_RGBA(r,g,b,a)						[UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#import "SHCPickView.h"
@interface SHCPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy) shc_backBlock selectBlock;
@property (nonatomic, copy) shc_actionBlock canceBlock;

@property (strong, nonatomic)UIPickerView *pickerView;

//保存选中文字
@property (nonatomic, strong)NSString *strAddress;//拼接
@property (nonatomic, strong)NSString *strProvince;//省
@property (nonatomic, strong)NSString *strCity;//市

@property (nonatomic, strong)NSMutableArray *arrayCityData;//市数据源

// 当前父视图
@property (nonatomic, strong) UIView *superViews;
@property (nonatomic, strong) UIView *viewContent;

@property (nonatomic, strong) UIView *views;

@end
@implementation SHCPickView

+(instancetype)showInView:(UIView *)view didSelectWithBlock:(shc_backBlock)block cancelBlock:(shc_actionBlock)cancel
{

    SHCPickView *pickView = [[SHCPickView alloc] init];
    //添加背景view
    pickView.views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shc_screenWidth, shc_screenHeight)];
    [view addSubview:pickView.views];
    pickView.views.backgroundColor = [UIColor blackColor];
    pickView.views.alpha = 0.6;
    pickView.views.hidden = NO;
    
    //添加view
    [view addSubview:pickView];
    pickView.frame = CGRectMake(0, shc_screenHeight, shc_screenWidth, 0);
    pickView.selectBlock = block;
    pickView.canceBlock = cancel;
    pickView.backgroundColor = [UIColor clearColor];
    return pickView;
}
- (void)showWithBlock:(void (^)())block
{
    [UIView animateWithDuration:self.interval animations:^{
        self.frame = CGRectMake(0, shc_screenHeight-self.viewHeight, shc_screenWidth, self.viewHeight);
    } completion:^(BOOL finished) {
        if (block) {
            block();
        }
    }];
}
- (void)dismissWithBlock:(void(^)())block {
    [UIView animateWithDuration:self.interval animations:^{
        [self.views removeFromSuperview];
        self.frame = CGRectMake(0, shc_screenHeight, shc_screenWidth, self.viewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (block) {
            block();
        }
    }];
}
//数据赋值
- (void)loadData
{
    _strAddress = @"";
    _strProvince = @"";
    _strCity = @"";
    if (self.inActionType == SHCBank) {
        
    }else
    {
        
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self loadData];
    [self viewContent];
    [self pickerView];
    [self showWithBlock:nil];
}
#pragma mark - 数据源
- (NSMutableArray *)arratData
{
    if (!_arratData) {
        _arratData = [NSMutableArray array];
    }
    return _arratData;
}
- (NSMutableArray *)arrayCityData
{
    if (!_arrayCityData) {
        _arrayCityData = [NSMutableArray array];
    }
    return _arrayCityData;
}

#pragma mark - 设置动画时间默认1秒
- (NSTimeInterval)interval
{
    if (!_interval) {
        _interval = 1;
    }
    return _interval;
}
#pragma mark - 设置高度
- (NSInteger)viewHeight
{
    if (!_viewHeight) {
        _viewHeight = 200;
    }
    return _viewHeight;
}
#pragma mark - 设置文本内容
- (NSDictionary *)textAttributes {
    if (_textAttributes == nil) {
        _textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]};
    }
    
    return _textAttributes;
}
#pragma mark - 创建确认按钮取消按钮
- (UIView *)viewContent
{
    if (_viewContent == nil) {
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shc_screenWidth, 50)];
        _viewContent.backgroundColor = [UIColor whiteColor];
        UIButton *butback = [UIButton buttonWithType:UIButtonTypeCustom];
        [butback setTitle:@"取消" forState:UIControlStateNormal];
        [butback setTitleColor:SHC_RGBA(83, 89, 104, 1) forState:UIControlStateNormal];
        butback.frame = CGRectMake(20, 0, 50, 50);
        butback.tag = 101;
        [butback addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_viewContent addSubview:butback];
        UIButton *butgo = [UIButton buttonWithType:UIButtonTypeCustom];
        [butgo setTitle:@"确定" forState:UIControlStateNormal];
        [butgo setTitleColor:SHC_RGBA(45, 149, 228, 1) forState:UIControlStateNormal];
        butgo.frame = CGRectMake(shc_screenWidth-70, 0, 50, 50);
        butgo.tag = 102;
        [butgo addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_viewContent addSubview:butgo];
        UIView *viewLink = [[UIView alloc] initWithFrame:CGRectMake(0, _viewContent.frame.size.height-0.5, shc_screenWidth, 0.5)];
        viewLink.backgroundColor = SHC_RGBA(227, 228, 229, 1);
        [_viewContent addSubview:viewLink];
        [self addSubview:_viewContent];
    }
    return _viewContent;
}
- (void)backBtn:(UIButton *)sender
{
    if (sender.tag == 101) {
        [self dismissWithBlock:nil];
    }else
    {
        // 选择结果回调
        if (self.selectBlock) {
            NSString *address = [NSString stringWithFormat:@"%@%@",_strProvince,_strCity];
            self.selectBlock(address,_strProvince,_strCity);
        }
        __weak typeof(self)ws = self;
        [self dismissWithBlock:^{
            if (ws.canceBlock) {
                ws.canceBlock();
            }
        }];
    }
}
#pragma mark - 创建pickView
- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, shc_screenWidth, self.viewHeight-50)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator=YES;
         [self addSubview:_pickerView];
    }
    return _pickerView;
}

#pragma mark - UIPickerView 代理和数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.inActionType == SHCBank) {
        return 1;
    }else
    {
        return 2;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.inActionType == SHCBank) {
        return self.arratData.count;
    }else
    {
        if (component == 0) {
            return self.arratData.count;
        } else{
            
            return self.arrayCityData.count;
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            
            singleLine.backgroundColor = [UIColor grayColor];//取消分割线
        }
    }
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (self.inActionType == SHCBank) {
        NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:[self.arratData objectAtIndex:row] attributes:self.textAttributes];
        _strProvince =[self.arratData objectAtIndex:row];
        label.attributedText = attStr;
    }else
    {
        if (component == 0) {
            NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:[self.arratData objectAtIndex:row] attributes:self.textAttributes];
            label.attributedText = attStr;
            _strProvince = [self.arratData objectAtIndex:row];
            [self arrDataR:[self.arratData objectAtIndex:row]];
        } else {
            NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:[self.arrayCityData objectAtIndex:row] attributes:self.textAttributes];
            _strCity = [self.arrayCityData objectAtIndex:row];
            label.attributedText = attStr;
        }
    }
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component  {
    if (self.inActionType == SHCBank) {
        if (self.selectBlock) {
            NSString *address = [NSString stringWithFormat:@"%@%@",[self.arratData objectAtIndex:row],@""];
            _strProvince = [self.arratData objectAtIndex:row];
            self.selectBlock(address,_strProvince,_strCity);
        }
    }else
    {
        if (component == 0) {
            
            [self arrDataR:[self.arratData objectAtIndex:row]];
            _strProvince = [self.arratData objectAtIndex:row];
            
            
        } else if (component == 1) {
            
            // 选择结果回调
            if (self.selectBlock) {
                NSString *address = [NSString stringWithFormat:@"%@%@",_strProvince,[self.arrayCityData objectAtIndex:row]];
                _strCity = [self.arrayCityData objectAtIndex:row];
                self.selectBlock(address,_strProvince,_strCity);
            }
        }
    }
}
- (void)arrDataR:(NSString *)city
{
    [self.arrayCityData removeAllObjects];
    if ([city isEqualToString:@"广东省"]) {
        NSArray *arr = @[@"dqdw",@"22222",@"efefefef",@"vvvvvv"];
        [self.arrayCityData addObjectsFromArray:arr];
    }else
    {
        NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
        [self.arrayCityData addObjectsFromArray:arr];
    }
    [_pickerView reloadComponent:1];
    [_pickerView selectRow:0 inComponent:1 animated:YES];
}

@end
