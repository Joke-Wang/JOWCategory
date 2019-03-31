//
//  ZZCheckPermission.m
//
//  Created by 王章仲 on 2017/12/7.
//  Copyright © 2017年 All rights reserved.
//

#import "ZZCheckPermission.h"


@interface ZZCheckPermission()
#pragma mark - 权限状态
#pragma mark 相册读取和写入权限状态
/**
 * 相册读取和写入权限状态
 */
@property (nonatomic, assign) PermissionStatus photoLibraryPermissionStatus;
#pragma mark 相机（摄像头）权限状态
/**
 * 相机（摄像头）权限状态
 */
@property (nonatomic, assign) PermissionStatus cameraPermissionStatus;
#pragma mark 麦克风（话筒）权限状态
/**
 * 麦克风（话筒）权限状态
 */
@property (nonatomic, assign) PermissionStatus audioPermissionStatus;
/**
 * 通讯录读取和写入权限状态
 */
@property (nonatomic, assign) PermissionStatus addressBookPermissionStatus;
@end

@implementation ZZCheckPermission
#pragma mark - 初始化（单利）
static ZZCheckPermission *_sharePermission = nil;
+ (instancetype)sharePermission {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharePermission = [[super allocWithZone:NULL] init];
    });
    return _sharePermission;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ZZCheckPermission sharePermission];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [ZZCheckPermission sharePermission];
}

#pragma mark - 照片库（相册）权限获取
/**
 *相册读取和写入权限
 
 *未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithPhotoLibrary {
    
    return [[ZZCheckPermission sharePermission] checkPermissionWithPhotoLibraryOfAutomaticRequest:true operation:nil];
    
}

/**
 *相册读取和写入权限
 
 @param operation 授权状态
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
- (BOOL)checkPermissionWithPhotoLibraryOfAutomaticRequest:(BOOL)automaticRequest
                                                operation:(void(^)(PermissionStatus status))operation {
    
    if ([ZZCheckPermission sharePermission].photoLibraryPermissionStatus == Authorized) {
        
        [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
        
        return true;
    }
    else if ([ZZCheckPermission sharePermission].photoLibraryPermissionStatus == RestrictedOrDenied) {
        
        [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
        
        if (automaticRequest) {
            [ZZCheckPermission openTheSettingWithKey:@"NSPhotoLibraryUsageDescription" deviceName:@"照片"];
        }
        
        return false;
    }
    
    
#ifdef AfterIOS8
    switch ([PHPhotoLibrary authorizationStatus]) {
        case PHAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = NotDetermined;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            
            if (automaticRequest) {
                [[ZZCheckPermission sharePermission] requestPHPhotoLibraryOfOperation:operation];
            }
            
            return false;
            break;
            
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = RestrictedOrDenied;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            
            if (automaticRequest) {
                [ZZCheckPermission openTheSettingWithKey:@"NSPhotoLibraryUsageDescription" deviceName:@"照片"];
            }
            
            return false;
            break;
            
        case PHAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = Authorized;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            return true;
            break;
            
        default:
            break;
    }
#else
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = NotDetermined;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            
            if (automaticRequest) {
                [[ZZCheckPermission sharePermission] requestPHPhotoLibraryOfOperation:operation];
            }
            
            return false;
            break;
        case ALAuthorizationStatusRestricted:
        case ALAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = RestrictedOrDenied;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            
            
            if (automaticRequest) {
                [ZZCheckPermission openTheSettingWithKey:@"NSPhotoLibraryUsageDescription" deviceName:@"照片"];
            }
            
            return false;
            break;
            
        case ALAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = Authorized;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
            return true;
            break;
            
        default:
            return true;
            break;
    }
#endif
}

- (void)requestPHPhotoLibraryOfOperation:(void(^)(PermissionStatus status))operation {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
                [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = NotDetermined;
                break;
                
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = RestrictedOrDenied;
                break;
                
            case PHAuthorizationStatusAuthorized:
                [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = Authorized;
                break;
                
            default:
                break;
        }
        [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].photoLibraryPermissionStatus];
    }];
}


#pragma mark - 通讯录权限获取
/**
 * 通讯录读取和写入权限
 *
 * 未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithAddressBook {
    return [[ZZCheckPermission sharePermission] checkPermissionWithAddressBookOfAutomaticRequest:true operation:nil];
}

/**
 * 通讯录读取和写入权限
 *
 * @param operation 授权状态
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
- (BOOL)checkPermissionWithAddressBookOfAutomaticRequest:(BOOL)automaticRequest
                                               operation:(void(^)(PermissionStatus status))operation {
    
    if ([ZZCheckPermission sharePermission].addressBookPermissionStatus == Authorized) {
        
        [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
        
        return true;
    }
    else if ([ZZCheckPermission sharePermission].addressBookPermissionStatus == RestrictedOrDenied) {
        
        [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
        
        if (automaticRequest) {
            [ZZCheckPermission openTheSettingWithKey:@"NSContactsUsageDescription" deviceName:@"通讯录"];
        }
        
        return false;
    }
    
    
#ifdef AfterIOS9
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        case CNAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = NotDetermined;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            
            if (automaticRequest) {
                [[ZZCheckPermission sharePermission] requestAccessForContactsOfOperation:operation];
            }
            
            return false;
            break;

        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            
            if (automaticRequest) {
                [ZZCheckPermission openTheSettingWithKey:@"NSContactsUsageDescription" deviceName:@"通讯录"];
            }
            
            return false;
            break;

        case CNAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            return true;
            break;

        default:
            return true;
            break;
    }
#else
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    switch (authStatus) {
        case kABAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = NotDetermined;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            
            if (automaticRequest) {
                [[ZZCheckPermission sharePermission] requestAccessForContactsOfOperation:operation];
            }
            
            return false;
            break;

        case kABAuthorizationStatusRestricted:
        case kABAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            
            if (automaticRequest) {
                [ZZCheckPermission openTheSettingWithKey:@"NSContactsUsageDescription" deviceName:@"通讯录"];
            }
            
            return false;
            break;

        case kABAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
            return true;
            break;

        default:
            return true;
            break;
    }
#endif
}

- (void)requestAccessForContactsOfOperation:(void(^)(PermissionStatus status))operation {
#ifdef AfterIOS9
    CNContactStore * contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts
                           completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
         if (error) {
             NSLog(@"Error: %@", error);
             [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
         } else if (!granted) {
             [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
         } else {
             [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
         }
         [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
     }];
#else
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error: %@", error);
                [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            } else if (!granted) {
                [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            } else {
                [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
            }
            [ZZCheckPermission executeOperation:operation status:[ZZCheckPermission sharePermission].addressBookPermissionStatus];
        });
    });
#endif
}



#pragma mark - 相机（摄像头）/麦克风（话筒）权限获取
/**
 *相机（摄像头）/麦克风（话筒）读取和写入权限
 
 *未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithMediaType:(AVMediaType)media {
    if (!((media == AVMediaTypeVideo) || (media == AVMediaTypeAudio))) {
        return false;
    }
    
    return [[ZZCheckPermission sharePermission] checkPermissionWithMediaType:media automaticRequest:true operation:nil];
}

/**
 * 相机（摄像头）/麦克风（话筒）读取和写入权限
 *
 * @param operation 授权状态
 * @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 * @param automaticRequest 是否自动申请权限
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
- (BOOL)checkPermissionWithMediaType:(AVMediaType)media
                    automaticRequest:(BOOL)automaticRequest
                           operation:(void(^)(PermissionStatus status))operation {
    if (!((media == AVMediaTypeVideo) || (media == AVMediaTypeAudio))) {
        return false;
    }
    
    PermissionStatus status = [ZZCheckPermission sharePermission].cameraPermissionStatus;
    
    if (media == AVMediaTypeAudio) {
        status = [ZZCheckPermission sharePermission].audioPermissionStatus;
    }
    
    
    if (status == Authorized) {
        
        [ZZCheckPermission executeOperation:operation status:status];
        
        return true;
    }
    else if (status == RestrictedOrDenied) {
        
        [ZZCheckPermission executeOperation:operation status:status];
        
        if (automaticRequest) {
            
            if (media == AVMediaTypeAudio) {
                [ZZCheckPermission openTheSettingWithKey:@"NSMicrophoneUsageDescription" deviceName:@"麦克风"];
            } else {
                [ZZCheckPermission openTheSettingWithKey:@"NSCameraUsageDescription" deviceName:@"相机"];
            }
            
        }
        
        return false;
    }
    
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:media];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            if (media == AVMediaTypeAudio) {
                [ZZCheckPermission sharePermission].audioPermissionStatus = NotDetermined;
            } else {
                [ZZCheckPermission sharePermission].cameraPermissionStatus = NotDetermined;
            }
            [ZZCheckPermission executeOperation:operation status:RestrictedOrDenied];
            
            if (automaticRequest) {
                [[ZZCheckPermission sharePermission] requestPermissionForMediaType:media operation:operation];
            }
            
            return false;
            break;
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            if (media == AVMediaTypeAudio) {
                [ZZCheckPermission sharePermission].audioPermissionStatus = RestrictedOrDenied;
                
                if (automaticRequest) {
                    [ZZCheckPermission openTheSettingWithKey:@"NSMicrophoneUsageDescription" deviceName:@"麦克风"];
                }
                
            } else {
                [ZZCheckPermission sharePermission].cameraPermissionStatus = RestrictedOrDenied;
                
                if (automaticRequest) {
                    [ZZCheckPermission openTheSettingWithKey:@"NSCameraUsageDescription" deviceName:@"相机"];
                }
                
            }
            
            [ZZCheckPermission executeOperation:operation status:RestrictedOrDenied];
            
            return false;
            break;
            
        case AVAuthorizationStatusAuthorized:
            if (media == AVMediaTypeAudio) {
                [ZZCheckPermission sharePermission].audioPermissionStatus = Authorized;
            } else {
                [ZZCheckPermission sharePermission].cameraPermissionStatus = Authorized;
            }
            
            [ZZCheckPermission executeOperation:operation status:Authorized];
            
            return true;
            break;
            
        default:
            break;
    }
}

/**
 *申请权限开通(摄像头/麦克风)

 @param media AVMediaTypeVideo or AVMediaTypeAudio
 */
- (void)requestPermissionForMediaType:(AVMediaType)media
                            operation:(void(^)(PermissionStatus status))operation {
    [AVCaptureDevice requestAccessForMediaType:media
                             completionHandler:^(BOOL granted)
     {
         if (media == AVMediaTypeAudio) {
             self.audioPermissionStatus = granted ? Authorized : RestrictedOrDenied;
             [ZZCheckPermission executeOperation:operation status:self.audioPermissionStatus];
         } else {
             self.cameraPermissionStatus = granted ? Authorized : RestrictedOrDenied;
             [ZZCheckPermission executeOperation:operation status:self.cameraPermissionStatus];
         }
     }];
}





#pragma mark - 提示用户需要获取权限（提供跳转至设置页面）
/**
 * 提示用户需要获取权限（提供跳转至设置页面）
 *
 * @param key plist声明权限对应的key
 * @param deviceName 设备
 */
+ (void)openTheSettingWithKey:(NSString *)key
                   deviceName:(NSString *)deviceName
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = [infoDic objectForKey:@"CFBundleDisplayName"];
    if (!name) {
        name = [infoDic objectForKey:@"CFBundleName"];
    }
    NSString *title =[NSString stringWithFormat:@"“%@”想访问您的%@", name, deviceName];
    NSString *message = [infoDic objectForKey:key];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        
        [alert addAction:action0];
        [alert addAction:action1];
        
        [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:alert animated:true completion:nil];
        
    });
    
}

+ (void)executeOperation:(void(^)(PermissionStatus status))operation
                  status:(PermissionStatus)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (operation) {
            operation(status);
        }
    });
}


@end
