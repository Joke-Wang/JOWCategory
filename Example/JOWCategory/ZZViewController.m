//
//  ZZViewController.m
//  JOWCategory
//
//  Created by Joke-Wang on 12/19/2018.
//  Copyright (c) 2018 Joke-Wang. All rights reserved.
//

#import "ZZViewController.h"
#import <JOWCategory/JOWCategory.h>
#import <JOWCategory/JOWRSAone.h>
#import "RSA.h"

@interface ZZViewController ()

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *message = @"1234567812345678bay8765432187654321";
    NSString *publickKey = @"MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAM2LdxhTNtabXRDQzr2f4I7ygqXaPXAVvs9HkgY92dpQxj6iP7J4AgPB13GUvS2KiSop159W5mxeC8Trq7gx3DsCAwEAAQ==";
    
    NSString *proviteKey = @"MIIBOwIBAAJBAM2LdxhTNtabXRDQzr2f4I7ygqXaPXAVvs9HkgY92dpQxj6iP7J4AgPB13GUvS2KiSop159W5mxeC8Trq7gx3DsCAwEAAQJBAIOkzTQhJ8AvZV29vouod/RV0eNTcYH2C21KU3X36y1s5BxxUEpqFbDO9zRZLg6+Z1ecZBrx7tYjSEVlxFv0WOECIQDyyirupydOwt+w/XboL8719+WtVs/G5GIZNCYdvWmHwwIhANi6grq95F5vY/YnUL58esdOZYQstDI69xDZXKcutIopAiBsquoeWThxuy1N1ZSkBcn3M5ZcSC/FULFLoJiy1PVn6wIgUz/hc4X5sOSsyyLy+xipuOE+UXUyipDn0osL8hQYuXECIQDeYLPHz2bKIP+HbVxz+Z2NyA0Eh5J9vizHWDro3xGvRQ==";
    
//    NSString *publickValue = [JOWRSA jowrea_encryptString:message
//                                                publicKey:publickKey];
//
//    NSString *proviteValue = [JOWRSA jowrea_decryptString:publickValue
//                                               privateKey:proviteKey];
    
    NSString *publickValue = [RSA encryptString:message
                                      publicKey:publickKey];
    
    NSString *proviteValue = [RSA decryptString:publickValue
                                     privateKey:proviteKey];
    NSLog(@"\n%@", publickValue);
    NSLog(@"\n%@", proviteValue);
    
    
    
//    NSString *publickValue1 = [JOWRSAone jowrea_encryptString:message
//                                         publicKey:publickKey];
//    NSString *proviteValue1 = [JOWRSAone jowrea_decryptString:publickValue1
//                                            privateKey:proviteKey];
//
//    NSLog(@"\n%@", publickValue1);
//    NSLog(@"\n%@", proviteValue1);
    
}
- (IBAction)accessAddressBook:(id)sender {
    [ZZCheckPermission checkPermissionWithAddressBook];
}

- (IBAction)accessCamera:(id)sender {
    [ZZCheckPermission checkPermissionWithMediaType:AVMediaTypeVideo];
}

- (IBAction)accessMicrophone:(id)sender {
    [ZZCheckPermission checkPermissionWithMediaType:AVMediaTypeAudio];
}

- (IBAction)accessPhotoAlbum:(id)sender {
    [ZZCheckPermission checkPermissionWithPhotoLibrary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
