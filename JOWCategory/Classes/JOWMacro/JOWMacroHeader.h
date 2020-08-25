//
//  JOWMacroHeader.h
//  JOWCategory
//
//  Created by super on 2020/8/25.
//

#ifndef JOWMacroHeader_h
#define JOWMacroHeader_h


//------- 设备类型判断 begin -------
// MARK: - 设备类型判断
//判断是否是ipad
#ifndef JOW_isIPad
#define JOW_isIPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#endif

//判断是否是iPhone
#ifndef JOW_iIPhoneOrTouch
#define JOW_isIPhoneOrTouch  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#endif

//MARK: 根据X系列的安全区 判断是否是X系列
#ifndef JOW_isIPhoneX
static inline BOOL JOW_isIPhoneX() {
    BOOL _iPhoneX = false;
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0.0) {
            _iPhoneX = true;
        }
    }
    return _iPhoneX;
}
#define iPhoneX (isIPhoneX())
#endif

//------- 设备类型判断 end -------





#endif /* JOWMacroHeader_h */
