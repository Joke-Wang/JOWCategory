//
//  ZZCheckPermission.h
//
//  Created by 王章仲 on 2017/12/7.
//  Copyright © 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>

#define isiOS12 ([[[UIDevice currentDevice] systemVersion] integerValue] == 12.0)
#define isiOS11 ([[[UIDevice currentDevice] systemVersion] integerValue] == 11.0)
#define isiOS10 ([[[UIDevice currentDevice] systemVersion] integerValue] == 10.0)
#define isiOS9  ([[[UIDevice currentDevice] systemVersion] integerValue] == 9.0)
#define isiOS8  ([[[UIDevice currentDevice] systemVersion] integerValue] == 8.0)
#define isiOS7  ([[[UIDevice currentDevice] systemVersion] integerValue] == 7.0)
#define isiOS6  ([[[UIDevice currentDevice] systemVersion] integerValue] == 6.0)

NSUInteger DeviceSystemMajorVersion(void);
#define AfterIOS12  (DeviceSystemMajorVersion() >= 12.0 ? YES : NO)
#define AfterIOS11  (DeviceSystemMajorVersion() >= 11.0 ? YES : NO)
#define AfterIOS10  (DeviceSystemMajorVersion() >= 10.0 ? YES : NO)
#define AfterIOS9   (DeviceSystemMajorVersion() >= 9.0  ? YES : NO)
#define AfterIOS8   (DeviceSystemMajorVersion() >= 8.0  ? YES : NO)
#define BeforeIOS8  (DeviceSystemMajorVersion() <  8.0  ? YES : NO)


#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

#ifdef AfterIOS9
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>
#else
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#endif


typedef NS_ENUM(NSUInteger, PermissionStatus) {
    NotDetermined       =   0,  //未进行授权（需要调用授权）
    RestrictedOrDenied  =   1,  //被限制或拒绝授权（进设置中修改）
    Authorized          =   2,  //已授权
};

#define kCheckPermission        [ZZCheckPermission sharePermission]

#define kPhotoLibraryPermission [ZZCheckPermission checkPermissionWithPhotoLibrary]
#define kCameraPermission       [ZZCheckPermission checkPermissionWithMediaType:AVMediaTypeVideo]
#define kMicrophonePermission   [ZZCheckPermission checkPermissionWithMediaType:AVMediaTypeAudio]
#define kContactsPermission     [ZZCheckPermission checkPermissionWithAddressBook]


/**
 * 获取权限状态
 */
@interface ZZCheckPermission : NSObject

#pragma mark - 初始化
+ (instancetype)sharePermission;

#pragma mark - 照片库（相册）权限获取
/**
 * 相册读取和写入权限
 *
 * 未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithPhotoLibrary;

/**
 * 相册读取和写入权限
 *
 * @param automaticRequest 是否自动申请权限
 * @param operation 授权状态
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
- (BOOL)checkPermissionWithPhotoLibraryOfAutomaticRequest:(BOOL)automaticRequest
                                                operation:(void(^)(PermissionStatus status))operation;

#pragma mark - 相机（摄像头）/麦克风（话筒）权限获取
/**
 * 相机（摄像头）/麦克风（话筒）读取和写入权限
 *
 * 未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 * @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithMediaType:(AVMediaType)media;

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
                           operation:(void(^)(PermissionStatus status))operation;


#pragma mark - 通讯录权限获取
/**
 * 通讯录读取和写入权限
 *
 * 未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithAddressBook;

/**
 * 通讯录读取和写入权限
 *
 * @param automaticRequest 是否自动申请权限
 * @param operation 授权状态
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
- (BOOL)checkPermissionWithAddressBookOfAutomaticRequest:(BOOL)automaticRequest
                                               operation:(void(^)(PermissionStatus status))operation;



@end
