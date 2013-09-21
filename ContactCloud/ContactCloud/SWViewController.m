//
//  SWViewController.m
//  ContactCloud
//
//  Created by Romi Phadte on 9/20/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWViewController.h"
#import <Parse/Parse.h>

#import "SWDataUploader.h"

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWDataUploader *uploader = [[SWDataUploader alloc] init];
    [uploader uploadAddressBookWithCompletion:^(NSError *error) {
        if(error){
            NSLog(@"error: %@", error);
        }
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
