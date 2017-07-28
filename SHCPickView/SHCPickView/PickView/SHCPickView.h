//
//  SHCPickView.h
//  SHCPickView
//
//  Created by gcct on 2017/7/26.
//  Copyright © 2017年 sunhaichen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^shc_backBlock)(NSString *ourAddress, NSString *province, NSString *city);
typedef void(^shc_actionBlock)();

@interface SHCPickView : UIView
/*
 * 区分银行卡与地区选择
 * SHCCity：地区 SHCBank：银行卡
 */
typedef enum {
    SHCCity,
    SHCBank,
}CityAndBankType;
@property (nonatomic, assign) NSInteger inActionType;
/* 数据源 */
@property (nonatomic, strong)NSMutableArray *arratData;

/** 动画时间间隔 默认 1s*/

@property (nonatomic, assign) NSTimeInterval interval;

/** 设置view高 默认200*/
@property (nonatomic, assign) NSInteger viewHeight;

/** 选择器文本内容字体属性,默认:蓝色,14号 */
@property (strong, nonatomic)NSDictionary *textAttributes;


/**
 *  @author SHC
 *
 *  创建,添加选择器
 *
 *  @param view 添加到的视图
 *  @param block 选择结果回调
 *
 *  @return 选择器实例
 */
+(instancetype)showInView:(UIView*)view didSelectWithBlock:(shc_backBlock)block cancelBlock:(shc_actionBlock)cancel;
-(void)showWithBlock:(void(^)())block;
-(void)dismissWithBlock:(void(^)())block;
@end
