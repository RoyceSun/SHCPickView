# SHCPickView
可分别展示一列与两列的PickView
```Objective-C
/**
*  @author SHC
*
*  创建,添加选择器
*
*  @param view   添加到的视图
*  @param block  选择结果回调
*  @param cancel 选择结果回调      
*
*  @return 选择器实例
*/
+(instancetype)showInView:(UIView*)view didSelectWithBlock:(shc_backBlock)block cancelBlock:(shc_actionBlock)cancel;
```
```Objective-C
/* 数据源 */
@property (nonatomic, strong)NSMutableArray *arratData;

/** 动画时间间隔 默认 1s*/

@property (nonatomic, assign) NSTimeInterval interval;

/** 设置view高 默认200*/
@property (nonatomic, assign) NSInteger viewHeight;

/** 选择器文本内容字体属性,默认:蓝色,14号 */
@property (strong, nonatomic)NSDictionary *textAttributes;

/* 
 *选择要显示的列数 
 *inActionType = SHCCity;两列  inActionType = SHCBank;一列
*/
@property (nonatomic, assign) NSInteger inActionType;

```


![](https://raw.githubusercontent.com/RoyceSun/SHCPickView/master/SHCPickView/SHCPickView/Image/123.gif)
