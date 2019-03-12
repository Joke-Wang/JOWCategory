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
@property (nonatomic, assign, readwrite) PermissionStatus photoLibraryPermissionStatus;
#pragma mark 相机（摄像头）权限状态
/**
 * 相机（摄像头）权限状态
 */
@property (nonatomic, assign, readwrite) PermissionStatus cameraPermissionStatus;
#pragma mark 麦克风（话筒）权限状态
/**
 * 麦克风（话筒）权限状态
 */
@property (nonatomic, assign, readwrite) PermissionStatus audioPermissionStatus;
/**
 * 通讯录读取和写入权限状态
 */
@property (nonatomic, assign, readwrite) PermissionStatus addressBookPermissionStatus;
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
    [self checkPermissionWithPhotoLibraryOfOperation:^(PermissionStatus status) {
        switch (status) {
            case NotDetermined:
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
                    
                }];
                break;
            case RestrictedOrDenied:
                [self openTheSettingWithKey:@"NSPhotoLibraryUsageDescription" deviceName:@"照片"];
                break;
                
            default:
                break;
        }
    }];
    
    return [self checkPermissionWithPhotoLibraryOfOperation:nil];
}

/**
 *相册读取和写入权限
 
 @param operation 授权状态
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithPhotoLibraryOfOperation:(void(^)(PermissionStatus status))operation {
#ifdef AfterIOS8
    switch ([PHPhotoLibrary authorizationStatus]) {
        case PHAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = NotDetermined;
            [self executeOperation:operation status:NotDetermined];
            return false;
            break;
            
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = RestrictedOrDenied;
            [self executeOperation:operation status:RestrictedOrDenied];
            return false;
            break;
            
        case PHAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = Authorized;
            [self executeOperation:operation status:Authorized];
            return true;
            break;
            
        default:
            break;
    }
#else
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = NotDetermined;
            [self executeOperation:operation status:NotDetermined];
            return false;
            break;
        case ALAuthorizationStatusRestricted:
        case ALAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = RestrictedOrDenied;
            [self executeOperation:operation status:RestrictedOrDenied];
            return false;
            break;
            
        case ALAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].photoLibraryPermissionStatus = Authorized;
            [self executeOperation:operation status:Authorized];
            return true;
            break;
            
        default:
            return true;
            break;
    }
#endif
}


#pragma mark - 通讯录权限获取
/**
 * 通讯录读取和写入权限
 *
 * 未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithAddressBook {
    [self checkPermissionWithAddressBookOfOperation:^(PermissionStatus status) {
        
        switch (status) {
            case NotDetermined:
                [self requestAccessForContacts];
                break;
            case RestrictedOrDenied:
                [self openTheSettingWithKey:@"NSContactsUsageDescription" deviceName:@"通讯录"];
                break;

            default:
                break;
        }
        
    }];
    return [self checkPermissionWithAddressBookOfOperation:nil];
}

+ (void)requestAccessForContacts {
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
        });
    });
#endif
}

/**
 * 通讯录读取和写入权限
 *
 * @param operation 授权状态
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithAddressBookOfOperation:(void(^)(PermissionStatus status))operation {
#ifdef AfterIOS9
    switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
        case CNAuthorizationStatusNotDetermined:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = NotDetermined;
            [self executeOperation:operation status:NotDetermined];
            return false;
            break;

        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            [self executeOperation:operation status:RestrictedOrDenied];
            return false;
            break;

        case CNAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
            [self executeOperation:operation status:Authorized];
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
            [self executeOperation:operation status:NotDetermined];
            return false;
            break;

        case kABAuthorizationStatusRestricted:
        case kABAuthorizationStatusDenied:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = RestrictedOrDenied;
            [self executeOperation:operation status:RestrictedOrDenied];
            return false;
            break;

        case kABAuthorizationStatusAuthorized:
            [ZZCheckPermission sharePermission].addressBookPermissionStatus = Authorized;
            [self executeOperation:operation status:Authorized];
            return true;
            break;

        default:
            return true;
            break;
    }
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
    
    ZZCheckPermission *permissionStatus = [ZZCheckPermission sharePermission];
    
    [self checkPermissionWithMediaType:media
                             operation:^(PermissionStatus status)
    {
        switch (status) {
            case NotDetermined:
                [permissionStatus requestPermissionForMediaType:media];
                break;
                
            case RestrictedOrDenied:
                if (media == AVMediaTypeAudio) {
                    [self openTheSettingWithKey:@"NSMicrophoneUsageDescription" deviceName:@"麦克风"];
                } else {
                    [self openTheSettingWithKey:@"NSCameraUsageDescription" deviceName:@"相机"];
                }
                break;
                
            default:
                break;
        }
    }];
    
    return [self checkPermissionWithMediaType:media operation:nil];
}

/**
 *相机（摄像头）/麦克风（话筒）读取和写入权限
 
 @param operation 授权状态
 @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithMediaType:(AVMediaType)media
                           operation:(void(^)(PermissionStatus status))operation {
    if (!((media == AVMediaTypeVideo) || (media == AVMediaTypeAudio))) {
        return false;
    }
    
    ZZCheckPermission *permissionStatus = [ZZCheckPermission sharePermission];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:media];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            if (media == AVMediaTypeAudio) {
                permissionStatus.audioPermissionStatus = NotDetermined;
            } else {
                permissionStatus.cameraPermissionStatus = NotDetermined;
            }
            [self executeOperation:operation status:NotDetermined];
            return false;
            break;
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            if (media == AVMediaTypeAudio) {
                permissionStatus.audioPermissionStatus = RestrictedOrDenied;
            } else {
                permissionStatus.cameraPermissionStatus = RestrictedOrDenied;
            }
            [self executeOperation:operation status:RestrictedOrDenied];
            return false;
            break;
            
        case AVAuthorizationStatusAuthorized:
            if (media == AVMediaTypeAudio) {
                permissionStatus.audioPermissionStatus = Authorized;
            } else {
                permissionStatus.cameraPermissionStatus = Authorized;
            }
            [self executeOperation:operation status:Authorized];
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
- (void)requestPermissionForMediaType:(AVMediaType)media {
    [AVCaptureDevice requestAccessForMediaType:media
                             completionHandler:^(BOOL granted)
     {
         if (media == AVMediaTypeAudio) {
             self.audioPermissionStatus = granted ? Authorized : RestrictedOrDenied;
         } else {
             self.cameraPermissionStatus = granted ? Authorized : RestrictedOrDenied;
         }
     }];
}





#pragma mark - 提示用户需要获取权限（提供跳转至设置页面）
/**
 *提示用户需要获取权限（提供跳转至设置页面）

 @param message 提示信息
 */
+ (void)openTheSettingWithKey:(NSString *)key
                   deviceName:(NSString *)deviceName
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = [infoDic objectForKey:@"CFBundleDisplayName"];
    NSString *title =[NSString stringWithFormat:@"\“%@”想访问您的%@", name, deviceName];
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
