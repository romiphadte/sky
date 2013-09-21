//
//  SWDataUploader.m
//  ContactCloud
//
//  Created by Siddhant Dange on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWDataUploader.h"
#import "VBAddressBookGrabber.h"
#import <Parse/Parse.h>

@interface SWDataUploader ()

@property (nonatomic, strong) VBAddressBookGrabber *grabber;

@end

@implementation SWDataUploader



-(void)uploadAddressBookWithCompletion:(void(^)(NSError*))completionBlock{
    NSArray* addressBook = [NSArray new];
    
    __block NSError *errorVal = nil;
    for (NSDictionary *person in addressBook) {
        PFObject *testObject = [PFObject objectWithClassName:@"People"];
        [testObject setObject:@"firstname" forKey:person[@"firstname"]];
        [testObject setObject:@"lastname" forKey:person[@"firstname"]];
        [testObject setObject:@"number" forKey:person[@"number"]];
        [testObject setObject:@"email" forKey:person[@"email"]];
        [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(error){
                NSLog(@"error saving %@ : %@", testObject, error);
                errorVal = error;
            }
        }];
    }
    
    completionBlock(errorVal);
}

@end
