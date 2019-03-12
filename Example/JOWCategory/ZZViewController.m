//
//  ZZViewController.m
//  JOWCategory
//
//  Created by Joke-Wang on 12/19/2018.
//  Copyright (c) 2018 Joke-Wang. All rights reserved.
//

#import "ZZViewController.h"
#import <JOWCategory/JOWCategory.h>

@interface ZZViewController ()

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
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
