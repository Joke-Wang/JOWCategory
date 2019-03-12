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


typedef enum : NSUInteger {
    NotDetermined,      //未进行授权（需要调用授权）
    RestrictedOrDenied, //被限制或拒绝授权（进设置中修改）
    Authorized,         //已授权
} PermissionStatus;     //授权状态

/**
 * 获取权限状态
 */
@interface ZZCheckPermission : NSObject

/**
 * 相册读取和写入权限状态
 */
@property (nonatomic, assign, readonly) PermissionStatus photoLibraryPermissionStatus;
/**
 * 相机（摄像头）权限状态
 */
@property (nonatomic, assign, readonly) PermissionStatus cameraPermissionStatus;
/**
 * 麦克风（话筒）权限状态
 */
@property (nonatomic, assign, readonly) PermissionStatus audioPermissionStatus;
/**
 * 通讯录读取和写入权限状态
 */
@property (nonatomic, assign, readonly) PermissionStatus addressBookPermissionStatus;

#pragma mark - 初始化
+ (instancetype)sharePermission;

#pragma mark - 照片库（相册）权限获取
/**
 *相册读取和写入权限
 
 *未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithPhotoLibrary;

/**
 *相册读取和写入权限

 @param operation 授权状态
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithPhotoLibraryOfOperation:(void(^)(PermissionStatus status))operation;

#pragma mark - 相机（摄像头）/麦克风（话筒）权限获取
/**
 *相机（摄像头）/麦克风（话筒）读取和写入权限
 
 *未授权，自动调用授权；授权关闭，提示并跳转到设置页面
 @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithMediaType:(AVMediaType)media;

/**
 *相机（摄像头）/麦克风（话筒）读取和写入权限
 
 @param operation 授权状态
 @param media AVMediaTypeVideo（相机） or AVMediaTypeAudio（麦克风）
 @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithMediaType:(AVMediaType)media
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
 * @param operation 授权状态
 * @return 已授权（true）；未授权/拒绝授权/被限制（false）
 */
+ (BOOL)checkPermissionWithAddressBookOfOperation:(void(^)(PermissionStatus status))operation;



@end
