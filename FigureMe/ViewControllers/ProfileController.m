//
//  ProfileController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "ProfileController.h"

@interface ProfileController ()

@end

@implementation ProfileController
@synthesize lblDateOfBirthDetail,lblLocationDetail,lblScoreDetail,txtViewAboutMeDetail,imgViewProfilePic;
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
    
    
    
    [lblScoreDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [lblDateOfBirthDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [lblLocationDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [txtViewAboutMeDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [txtViewAboutMeDetail resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnEditProfileClicked:(id)sender {
    [self performSegueWithIdentifier:@"PushToEditProfile" sender:self];
}




@end
