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
    
    self.viewLocationContainer.layer.cornerRadius =
    self.viewDOBContainer.layer.cornerRadius =
    self.viewScoreContainer.layer.cornerRadius =
    self.viewAboutMeContainer.layer.cornerRadius =5.0f;
    
    
    NSMutableURLRequest *_request = [CommanFunctions getProfileRequest:@"12"];
    _request.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting  objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
                 
             {
                 
                 NSDictionary *Profiles = [[greeting objectForKey:@"data"] objectForKey:@"user"];
                 
                 lblDateOfBirthDetail.text =[Profiles objectForKey:@"BirthDate"];
                 lblLocationDetail.text = [NSString stringWithFormat:@"%@",[Profiles objectForKey:@"Location"]];
                 lblScoreDetail.text = @"120";
                 txtViewAboutMeDetail.text = [Profiles objectForKey:@"About_you"];
                 imgViewProfilePic.image= [UIImage imageNamed:@"image2.jpg"];
                 
                 
                 self.imgViewProfilePic.layer.cornerRadius = self.imgViewProfilePic.frame.size.width / 2;
                 self.imgViewProfilePic.clipsToBounds = YES;
                 self.imgViewProfilePic.backgroundColor = [UIColor whiteColor];
                 [self.imgViewProfilePic setContentMode:UIViewContentModeScaleAspectFill];
                
                 
             }
         }
         
         
     }];
    
    
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
