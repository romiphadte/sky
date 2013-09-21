//
//  SWCardViewController.m
//  ContactCloud
//
//  Created by Neeraj Baid on 9/21/13.
//  Copyright (c) 2013 Romi Phadte. All rights reserved.
//

#import "SWCardViewController.h"

@interface SWCardViewController ()

@property (strong,nonatomic) NSString* first;
@property (strong, nonatomic) NSString* last;
@property (strong, nonatomic) NSString* phone;

@end

@implementation SWCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_firstLabel setText:_first];
    [_lastLabel setText:_last];
    if(_phone){
    [_phoneLabel setText:_phone];
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCardData:(NSDictionary *)selectedPerson{
    _first=selectedPerson[@"First"];
    _last=selectedPerson[@"Last"];
    _phone=selectedPerson[@"Phone"];
}

@end
