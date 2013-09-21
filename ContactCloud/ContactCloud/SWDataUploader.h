//
//  SWDataUploader.h
//  ContactCloud
//
//  Created by Siddhant Dange on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWDataUploader : NSObject

-(SWDataUploader*)init;
-(void)uploadAddressBookWithCompletion:(void(^)(NSError*))completionBlock;

@end
