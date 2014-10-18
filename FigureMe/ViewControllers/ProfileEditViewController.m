//
//  ProfileEditViewController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "ProfileEditViewController.h"

@interface ProfileEditViewController ()

@end

@implementation ProfileEditViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"modalSocialConnect"]) {
        UIButton *tempbutton = (UIButton*)sender;
        SocialConnectController *destViewController = segue.destinationViewController;
        switch (tempbutton.tag) {
            case 0:
                
                break;
            case 1:
                destViewController.network = NetworkTypeTwitter;
                break;
            case 2:
                
                break;
            case 3:
                
                break;

            default:
                break;
        }
    }
}

- (IBAction)btnSaveProfileClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnFacebookClicked:(id)sender {
    
}

- (IBAction)btnTwitterClicked:(id)sender {
    [self performSegueWithIdentifier:@"modalSocialConnect" sender:sender];
}
@end
