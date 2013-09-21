//
//  SWCardViewController.h
//  ContactCloud
//
//  Created by Neeraj Baid on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

-(void) setCardData:(NSDictionary*) selectedPerson;
@end
