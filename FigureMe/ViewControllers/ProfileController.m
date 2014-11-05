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
@synthesize objUserProfile;

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
    
    [lblScoreDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [lblDateOfBirthDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [lblLocationDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    [txtViewAboutMeDetail setFont:[UIFont fontWithName:@"OpenSans-Light" size:12.0]];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [self addOverLay];

    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kTwitterTokenKey])
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter-g"];
    else
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter"];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kFacebookTokenKey])
        self.btnSocialConnectFB.imageView.image = [UIImage imageNamed:@"facebook-g"];
    else
        self.btnSocialConnectFB.imageView.image = [UIImage imageNamed:@"facebook"];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kInstagramTokenKey])
        self.btnSocialConnectInstagram.imageView.image = [UIImage imageNamed:@"instagramme-g"];
    else
        self.btnSocialConnectInstagram.imageView.image = [UIImage imageNamed:@"instagramme"];
    
    /*
    if([[NSUserDefaults standardUserDefaults] objectForKey:kTwitterTokenKey])
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter-g"];
    else
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter"];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kTwitterTokenKey])
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter-g"];
    else
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter"];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kTwitterTokenKey])
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter-g"];
    else
        self.btnSocialConnectTwitter.imageView.image = [UIImage imageNamed:@"twitter"];
    */
    
    
    self.objUserProfile = [[UserProfile alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString*UID=[defaults objectForKey:@"UID"];
    
    NSMutableURLRequest *_request = [CommanFunctions getProfileRequest:UID];
    _request.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         [self removeOverLay];
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting  objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
                 
             {
                 
                 NSDictionary *Profiles = [[greeting objectForKey:@"data"] objectForKey:@"user"];
                 
                 NSString *stringfortime = [Profiles objectForKey:@"BirthDate"];
                 
                 if ([stringfortime isEqualToString:@"0000-00-00"])
                 {
                     lblDateOfBirthDetail.text = @"Unavailable";
                     self.objUserProfile.strDOB = @"Unavailable";
                 }
                 else
                 {
                     //  NSString *myString = @"2012-11-22";
                     NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                     dateFormatter.dateFormat = @"yyyy-MM-dd";
                     NSDate *yourDate = [dateFormatter dateFromString:stringfortime];
                     dateFormatter.dateFormat = @"dd MMM, yyyy";
                     
                     NSString *output = [dateFormatter stringFromDate:yourDate];
                     
                     lblDateOfBirthDetail.text = output;
                     self.objUserProfile.strDOB = output;
                 }
                 
                 self.lblUsername.text =[Profiles objectForKey:@"UserName"];
                 self.objUserProfile.strUserName = [Profiles objectForKey:@"UserName"];
                 
                 // lblDateOfBirthDetail.text =[Profiles objectForKey:@"BirthDate"];
                 lblLocationDetail.text = [NSString stringWithFormat:@"%@",[Profiles objectForKey:@"Location"]];
                 
                 NSArray *locations = [lblLocationDetail.text componentsSeparatedByString:@","];
                 
                 if(locations.count>0)
                 {
                     self.objUserProfile.strLocationCity = [locations objectAtIndex:0];
                     if(locations.count>1)
                        self.objUserProfile.strLocationState = [locations objectAtIndex:1];
                 }
                 
                 lblScoreDetail.text = @"120";
                 self.objUserProfile.strScore = @"120";
                 
                 txtViewAboutMeDetail.text = [Profiles objectForKey:@"About_you"];
                 self.objUserProfile.strAboutMe = [Profiles objectForKey:@"About_you"];
                 
                 
                 UIColor *titlecolor= [UIColor colorWithRed:163./255. green:162./255. blue:169./255. alpha:158./255.];
                 self.lblInterests.font =[UIFont fontWithName:@"OpenSans-Bold" size:12];
                 //self.lblInterests.textColor = titlecolor;
                 
                 for (UIView *view in self.scrollViewInterets.subviews) {
                     [view removeFromSuperview];
                 }
                 self.objUserProfile.strInterest = [Profiles objectForKey:@"Interests"];
                 NSMutableArray *interests= [[[Profiles objectForKey:@"Interests"] componentsSeparatedByString:@","] mutableCopy];
                 
                 [interests removeObjectAtIndex:0];
                 
                 float y = 3;
                 float x = 3;
                 for (NSInteger i=0; i<interests.count; i++) {
                     NSString *interest = [interests objectAtIndex:i];
                     UIFont *font = [UIFont fontWithName:@"OpenSans-Bold" size:10];
                     UIColor *color= [UIColor colorWithRed:169./255. green:169./255. blue:169./255. alpha:169./255.];
                     
                     if((i+1)&1)
                     {
                         x=3;
                         if(i>1)
                             y+=21;
                     }
                     else
                     {
                         x=82;
                     }

                     UILabel *lblInterest = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 77, 17)];
                     lblInterest.backgroundColor = color;
                     lblInterest.layer.cornerRadius = 10;
                     lblInterest.clipsToBounds = YES;
                     
                     lblInterest.textAlignment = NSTextAlignmentCenter;
                     lblInterest.font = font;
                     lblInterest.textColor = [UIColor whiteColor];
                     lblInterest.text = interest;
                     
                     [self.scrollViewInterets addSubview:lblInterest];
                     [self.scrollViewInterets setContentSize:CGSizeMake(150, y+21)];
                 }

                 if(self.updatedImage){
                     [imgViewProfilePic setImage:self.updatedImage];
                 }
                 else{
                     [imgViewProfilePic setImageWithURL:[NSURL URLWithString:[Profiles objectForKey:@"Image"]] placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
                 }
                 self.objUserProfile.strProfilePic = [Profiles objectForKey:@"Image"];
                 
                 self.imgViewProfilePic.layer.cornerRadius = self.imgViewProfilePic.frame.size.width / 2;
                 self.imgViewProfilePic.clipsToBounds = YES;
                 self.imgViewProfilePic.backgroundColor = [UIColor whiteColor];
                 [self.imgViewProfilePic setContentMode:UIViewContentModeScaleAspectFill];
             }
         }
         
     }];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [txtViewAboutMeDetail resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)viewDidLayoutSubviews
{
    self.scrollViewInterets.contentSize = self.scrollViewInterets.contentSize;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProfileEditViewController *profileEdit = segue.destinationViewController;
    profileEdit.objUserProfile = self.objUserProfile;
}

- (IBAction)btnEditProfileClicked:(id)sender {
    [self performSegueWithIdentifier:@"PushToEditProfile" sender:self];
}

#pragma mark - Custom Delegates

- (void)addOverLay
{
    self.spinnerOverlay = [[UIView alloc] initWithFrame:self.view.frame];
    self.spinnerOverlay.backgroundColor = [UIColor blackColor];
    self.spinnerOverlay.alpha = 0.50f;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    [self.spinnerOverlay addSubview:self.spinner];
    [self.spinner startAnimating];
    
    [self.view addSubview:self.spinnerOverlay];
    [self.view bringSubviewToFront:self.spinnerOverlay];
}

- (void)removeOverLay
{
    [self.spinner stopAnimating];
    [self.spinnerOverlay removeFromSuperview];
}

@end
