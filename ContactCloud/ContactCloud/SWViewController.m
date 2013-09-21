//
//  SWViewController.m
//  ContactCloud
//
//  Created by Romi Phadte on 9/20/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWViewController.h"
#import <Parse/Parse.h>
#import "VBAddressBookGrabber.h"
@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"romi" forKey:@"foo"];
    [testObject save];
    [self authorizateAndGrab];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)authorizateAndGrab {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(NULL, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted) {
                    //[self checkAuthorizationStatus];
                    //return;
                    NSLog(@"not granted");
                }
                
                [self grabAddressBook];
            });
        });
    } else {
        [self grabAddressBook];
    }
}

- (void)grabAddressBook {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if (!addressBook) {
        return;
    }
    
    VBAddressBookGrabber *addressBookGrabber = [[VBAddressBookGrabber alloc] init];
    addressBookGrabber.grabbingProperties = [VBAddressBookGrabber allProperties];
    addressBookGrabber.propertyNames = [VBAddressBookGrabber localizedPropertyNames];
    addressBookGrabber.dateFormatter = [[NSDateFormatter alloc] init];
    addressBookGrabber.dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    NSArray *people = [addressBookGrabber grabAddressBook:addressBook];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:people options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //self.textView.text = jsonString;
    NSLog(@"Json %@",jsonString);
    CFRelease(addressBook);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
