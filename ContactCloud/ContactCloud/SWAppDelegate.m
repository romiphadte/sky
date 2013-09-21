//
//  SWAppDelegate.m
//  ContactCloud
//
//  Created by Romi Phadte on 9/20/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWAppDelegate.h"
#import <Parse/Parse.h>
#import <AddressBook/AddressBook.h>
#import "VBAddressBookGrabber.h"

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Xiosij1pA3HPiCSOmIBwcvVF9PQfMjR77JFu6G9P"
                  clientKey:@"2LkzEQDilncJr78zi7PRBKCcgBQZnqQ1P8zzytad"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self authorizateAndGrab];
    return YES;
}

- (void)authorizateAndGrab
{
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

- (void)grabAddressBook
{
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
    NSArray *realData = [NSArray array];
    
    for (int a = 0; a < [people count]; a++)
    {
        people = [people mutableCopy];
        NSDictionary *currentInfo = [people objectAtIndex:a];
        NSMutableDictionary *newInfo = [NSMutableDictionary dictionary];
        [newInfo setObject:@"NO" forKey:@"isFromServer"];
        [newInfo setObject:[[currentInfo objectForKey:@"Phone"] objectAtIndex:0] forKey:@"Phone"];
        [newInfo setObject:[currentInfo objectForKey:@"First"] forKey:@"First"];
        [newInfo setObject:[currentInfo objectForKey:@"Last"] forKey:@"Last"];
        NSString *fullName = [NSString stringWithFormat:@"%@ %@", [currentInfo objectForKey:@"First"], [currentInfo objectForKey:@"Last"]];
        [newInfo setObject:fullName forKey:@"FullName"];
        realData = [realData arrayByAddingObject:[NSDictionary dictionaryWithDictionary:newInfo]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:realData forKey:@"Local Contacts"];
//    NSLog(@"parsed data = %@", realData);
    CFRelease(addressBook);
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
