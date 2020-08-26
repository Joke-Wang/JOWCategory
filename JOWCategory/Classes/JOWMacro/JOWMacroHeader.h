//
//  JOWMacroHeader.h
//  JOWCategory
//
//  Created by super on 2020/8/25.
//

#ifndef JOWMacroHeader_h
#define JOWMacroHeader_h

//------- 设备系统类型判断 begin -------
// MARK: - 设备系统类型判断
#ifndef SYSTEM_VERSION_EQUAL_TO
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#endif

#ifndef SYSTEM_VERSION_GREATER_THAN
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#endif

#ifndef SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif

#ifndef SYSTEM_VERSION_LESS_THAN
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#endif

#ifndef SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif

//------- 设备系统类型判断 end -------


//------- 设备类型判断 begin -------
// MARK: - 设备类型判断
//判断是否是ipad
#ifndef JOW_isIPad
#define JOW_isIPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#endif

//判断是否是iPhone
#ifndef JOW_isIPhoneOrTouch
#define JOW_isIPhoneOrTouch  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#endif
//------- 设备类型判断 end -------


//------- 设备屏幕类型判断 begin -------
// MARK: - 设备屏幕类型判断
//MARK: 根据X系列的安全区 判断是否是X系列
/** 判断iPhone X系列的原理
 iPhone X Series 包含有安全区域的边距信息
                   {top, left, bottom, right}
 竖屏时 safeAreaInsets:    {44,    0,    34,       0}
 横屏时 safeAreaInsets:    {0,      44,  21,       44}
 所以，当bottom > 0（即，包含有Home Indicator区域），一定是X系列
 */
#ifndef JOW_isIPhoneX
static inline BOOL JOW_isIPhoneX() {
    BOOL _iPhoneXSeries = false;
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0.0) {
            _iPhoneXSeries = true;
        }
    }
    return _iPhoneXSeries;
}
#define iPhoneX_Series (JOW_isIPhoneX())
#endif

//------- 设备屏幕类型判断 end -------


//------- 屏幕布局相关（屏幕物理尺寸） begin -------
// MARK: - 获取设备的物理尺寸信息
#ifndef kScreenBounds
#define kScreenBounds   [UIScreen mainScreen].bounds
#endif

#ifndef kScreenWidth
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#endif

#ifndef kLongMargin
#define kLongMargin     MAX(kScreenWidth, kScreenHeight)
#endif

#ifndef kShortMargin
#define kShortMargin    MIN(kScreenWidth, kScreenHeight)
#endif

//获取状态栏高度(调用时的高度，设置隐藏是获取的值为0，显示时获取到实际的高度20.0/44.0)
#ifndef kStatusBar_Height
#define kStatusBar_Height CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])
#endif
// 竖屏 状态栏固定高度
#ifndef kStatusBar_FixedHeight
#define kStatusBar_FixedHeight (iPhoneX_Series ? 44.0 : 20.0)
#endif

// 获取导航栏高度(如果隐藏，返回高度为0)
#ifndef kNavBar_Height
#define kNavBar_Height  ((kCurrentViewController().navigationController.navigationBar.hidden) ? (0) : CGRectGetHeight(kCurrentViewController().navigationController.navigationBar.frame))
#endif
// 竖屏 导航栏固定高度
#ifndef kNavBar_FixedHeight
#define kNavBar_FixedHeight (JOW_isIPad ? 50.0 : 44.0)
#endif

// 获取刘海/下巴固定高度
#ifndef kBangs_FixedHeight
#define kBangs_FixedHeight (iPhoneX_Series ? 34.0 : 0.0)
#endif

// 获取标签栏高度
#ifndef kTabBar_Height
#define kTabBar_Height  ((kCurrentViewController().tabBarController.tabBar.hidden || kCurrentViewController().tabBarController.tabBar == nil) ? 0 : (CGRectGetHeight(kCurrentViewController().tabBarController.tabBar.frame) - kBangs_FixedHeight))
#endif
// 获取标签栏固定高度
#ifndef kTabBar_FixedHeight
#define kTabBar_FixedHeight (49.0)
#endif

// 获取头部高度（获取状态栏高度 + 获取导航栏高度）
#ifndef kTopBars_Height
#define kTopBars_Height         (((iPhoneX_Series && kNavBar_Height > 0) ? kStatusBar_FixedHeight : kStatusBar_Height) + kNavBar_Height)
#endif
// 获取头部固定高度（获取状态栏固定高度 + 获取导航栏固定高度）
#ifndef kTopBars_FixedHeight
#define kTopBars_FixedHeight    (kStatusBar_FixedHeight + kNavBar_FixedHeight)
#endif

// 获取底部高度（如果有tabbar底部高度为tabbar，如果没有tabbar，使用下部Home Indicator高度）
#ifndef kBottomBars_Height
#define kBottomBars_Height         (kTabBar_Height + kBangs_FixedHeight)
#endif
// 获取底部固定高度（获取tabbar固定高度（不包含Home Indicator） + 获取Home Indicator固定高度）
#ifndef kBottomBars_FixedHeight
#define kBottomBars_FixedHeight    (kTabBar_FixedHeight + kBangs_FixedHeight)
#endif

// 获取头部底部高度（获取头部高度 + 获取标签栏高度）
#ifndef kBars_Height
#define kBars_Height    (kTopBars_Height + kBottomBars_Height)
#endif

// 获取头部底部固定高度（获取头部固定高度 + 获取底部固定高度）
#ifndef kBars_FixedHeight
#define kBars_FixedHeight    (kTopBars_FixedHeight + kBottomBars_FixedHeight)
#endif


#ifndef kScale
#define kScale  (kScreenWidth/((kScreenWidth == kShortMargin) ? 375.0 : ((kLongMargin < 812.0) ? 812.0 : 667.0)))
#define kScaleW(L) (L * (float)kScale)
#endif



//------- 屏幕布局相关（屏幕物理尺寸） end -------


//------- 字体大小 begin -------
// MARK: - 字体大小
#ifndef kFonts
#define kFonts
#define kFont(F) [UIFont systemFontOfSize: F * kScale]
#define kBoldFont(F) [UIFont boldSystemFontOfSize:F * kScale]

#warning need set UIAppFonts(Fonts provided by application) in info.plist
#define kCustomFont(name, F) [UIFont fontWithName:name size:F * kScale] ? [UIFont fontWithName:name size:F * kScale] : [UIFont systemFontOfSize: F * kScale]
#define kCustomBoldFont(name, F) [UIFont fontWithName:name size:F * kScale] ? [UIFont fontWithName:name size:F * kScale] : [UIFont boldSystemFontOfSize: F * kScale]

#endif

//------- 字体大小 end -------


//------- 颜色 begin -------
// 颜色宏  参数格式为：0xFFFFFF
#ifndef UIColorFromHex
#define UIColorFromHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#endif

#ifndef UIColorFromRGBA
#define UIColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1.0)]
#endif

#ifndef UIColorFromRandom
#define UIColorFromRandom   UIColorFromRGB((arc4random()%255), (arc4random()%255), (arc4random()%255))
#endif

//------- 颜色 end -------



// MARK: - 1像素
#ifndef kOnePxHeight
#define kOnePxHeight  (kLineOnePxHeight())
static inline CGFloat kLineOnePxHeight() {
    return (1.0/[[UIScreen mainScreen] scale]);
}
#endif

// MARK: - 获取当前控制器
#ifndef kCurrentViewController_
#define kCurrentViewController_
static inline UIViewController * kCurrentViewController() {
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }
        else if([Rootvc isKindOfClass:[UITabBarController class]]) {
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:((tabVC.selectedIndex < tabVC.viewControllers.count) ? tabVC.selectedIndex : 0)];
            continue;
        }
        else if ([Rootvc isKindOfClass:[UIViewController class]]) {
            UIViewController * aVC = (UIViewController *)Rootvc;
            currVC = aVC;
            Rootvc = aVC.presentedViewController;
            continue;
        }
    } while (Rootvc!=nil);
    return currVC;
}
#endif

#endif /* JOWMacroHeader_h */
