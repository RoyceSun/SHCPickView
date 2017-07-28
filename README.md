# SHCPickView
可分别展示一列与两列的PickView
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


![](https://raw.githubusercontent.com/RoyceSun/SHCPickView/master/SHCPickView/SHCPickView/Image/123.gif)
