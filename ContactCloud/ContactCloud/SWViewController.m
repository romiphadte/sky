//
//  SWViewController.m
//  ContactCloud
//
//  Created by Romi Phadte on 9/20/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWViewController.h"
#import <Parse/Parse.h>

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"romi" forKey:@"foo"];
    [testObject save];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
