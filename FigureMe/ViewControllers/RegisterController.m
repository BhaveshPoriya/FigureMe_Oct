//
//  RegisterController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController

#pragma mark - Properties

@synthesize scrollView = _scrollView;

@synthesize txtUsername = _txtUsername,
txtEmail = _txtEmail,
txtPassword = _txtPassword,
txtRepeatPassword = _txtRepeatPassword;


#pragma mark - View Lifecycle

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
    self.isValidUsername = self.isValidEmail = self.isValidPassword = NO;
    [self.scrollView contentSizeToFit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Control Delegates

- (IBAction)btnCancelClicked:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)btnRegisterClicked:(id)sender{
    
    
    if(self.isValidUsername && self.isValidEmail && self.isValidPassword)
    {
        [self addOverLay];
        
        NSString *username = self.txtUsername.text;
        NSString *email = self.txtEmail.text;
        NSString *password = self.txtPassword.text;
        
        NSMutableURLRequest *_request = [CommanFunctions getRegisterRequest:username Email:email Password:password];
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
                     UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Registration Successful" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                     successAlert.tag = 101;
                     [successAlert show];
                 }
                 else
                 {
                     NSString *message = [[greeting objectForKey:@"data"] objectForKey:@"message"];
                     NSLog(@"%@",message);
                     [self removeOverLay];
                 }
             }
             else
             {
                 [self removeOverLay];
             }
         }];
        
    }
    else
    {
        if(!self.isValidUsername)
           [self.txtUsername becomeFirstResponder];
        else if(!self.isValidEmail)
            [self.txtEmail becomeFirstResponder];
        else if(!self.isValidPassword)
            [self.txtPassword becomeFirstResponder];
    }
    
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

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:{
            if([textField.text isEqualToString:@""])
            {
                self.imgViewUsernameValidation.image = [UIImage imageNamed:@"wrong"];
                self.isValidUsername = NO;
            }
            else
            {
            UIActivityIndicatorView *usernamespinner;
            usernamespinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [usernamespinner setCenter:CGPointMake(self.viewUsernameValidation.frame.size.width/2.0, self.viewUsernameValidation.frame.size.height/2.0)];
            [self.viewUsernameValidation addSubview:usernamespinner];
            [usernamespinner startAnimating];
            self.imgViewUsernameValidation.image = nil;

            NSString *_username = textField.text;
            
            NSMutableURLRequest *_request = [CommanFunctions getCheckUsernameRequest:_username];
            _request.timeoutInterval = 30;
            
            [NSURLConnection sendAsynchronousRequest:_request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 [usernamespinner removeFromSuperview];
                 if (data.length > 0 && connectionError == nil)
                 {
                     NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
                     if(![status isEqualToString:@"failed"])
                     {
                         self.imgViewUsernameValidation.image = [UIImage imageNamed:@"right"];
                         self.isValidUsername = YES;
                     }
                     else
                     {
                         self.imgViewUsernameValidation.image = [UIImage imageNamed:@"wrong"];
                         self.isValidUsername = NO;
                     }
                 }
             }];
            }
            break;
        }
        case 2:{
            if([textField.text isEqualToString:@""])
            {
                self.imgViewEmailValidation.image = [UIImage imageNamed:@"wrong"];
                self.isValidEmail = NO;
            }
            else if(![CommanFunctions IsValidEmail:textField.text])
            {
                self.imgViewEmailValidation.image = [UIImage imageNamed:@"wrong"];
                self.isValidEmail = NO;
            }
            else
            {
            UIActivityIndicatorView *emailspinner;
            emailspinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [emailspinner setCenter:CGPointMake(self.viewUsernameValidation.frame.size.width/2.0, self.viewUsernameValidation.frame.size.height/2.0)];
            [self.viewEmailValidation addSubview:emailspinner];
            [emailspinner startAnimating];
            self.imgViewEmailValidation.image = nil;

            
            NSString *_email = textField.text;
            
            NSMutableURLRequest *_request = [CommanFunctions getCheckEmailRequest:_email];
            _request.timeoutInterval = 30;
            
            [NSURLConnection sendAsynchronousRequest:_request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 [emailspinner removeFromSuperview];
                 if (data.length > 0 && connectionError == nil)
                 {
                     NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
                     if(![status isEqualToString:@"failed"])
                     {
                         self.imgViewEmailValidation.image = [UIImage imageNamed:@"right"];
                         self.isValidEmail = YES;
                     }
                     else
                     {
                         self.imgViewEmailValidation.image = [UIImage imageNamed:@"wrong"];
                         self.isValidEmail = NO;
                     }
                 }
             }];
            }
            break;
        }
        case 3:case 4:{
            if([self.txtPassword.text isEqualToString:@""] || [self.txtRepeatPassword.text isEqualToString:@""])
            {
                self.imgViewPasswordValidation.image = [UIImage imageNamed:@"wrong"];
                self.isValidPassword = NO;
            }
            else
            {
            if([self.txtPassword.text isEqualToString:textField.text])
            {
                self.imgViewPasswordValidation.image = [UIImage imageNamed:@"right"];
                self.isValidPassword = YES;
            }
            else
            {
                self.imgViewPasswordValidation.image = [UIImage imageNamed:@"wrong"];
                self.isValidPassword = NO;
            }
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - UIAlertView Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if(buttonIndex == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

   
@end
