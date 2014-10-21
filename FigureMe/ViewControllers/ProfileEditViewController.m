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
    [self.scrollView contentSizeToFit];
}


- (IBAction)btnSaveProfileClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnEditProfilePicClicked:(id)sender {
}

- (IBAction)btnFacebookClicked:(id)sender {
    [self performSegueWithIdentifier:@"modalSocialConnectFB" sender:sender];
}

- (IBAction)btnTwitterClicked:(id)sender {
    [self performSegueWithIdentifier:@"modalSocialConnectTwitter" sender:sender];
}

- (IBAction)btnInstalgramClicked:(id)sender {
    [self performSegueWithIdentifier:@"modalSocialConnectInstagram" sender:sender];
}

- (IBAction)btnLinkedInClicked:(id)sender {
    //[self performSegueWithIdentifier:@"modalSocialConnectLinkedIn" sender:sender];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    return cell;
}

@end
