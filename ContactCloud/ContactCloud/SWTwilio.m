//
//  SWTwilio.m
//  ContactCloud
//
//  Created by Romi Phadte on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWTwilio.h"

@implementation SWTwilio

-(void)sendTextToNumber:(NSNumber *)number{
    NSString *accountSID=@"AC9ae6bb04776d1ba3c08527b96b1fcf35";
    NSString *AuthToken=@"4ca34d50e9b9ca9f9155f0b455073c74";
    NSString* url=[NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/Messages", accountSID, AuthToken,accountSID];
    NSURL *twilioURL=[[NSURL alloc]initWithString:url];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:twilioURL];
    
    NSString* parameters=@"From=%2B14083009185&To=408-642-8972&Body=hello%0D%0A";
    
    NSData *data=[parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    
    NSURLResponse *releasing=nil;
    
    NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:&releasing error:&error];
    NSString* responseString=[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(responseString);

}

@end
