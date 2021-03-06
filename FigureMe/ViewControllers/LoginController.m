//
//  LoginController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

#pragma mark - Properties
@synthesize txtUsername = _txtUsername,
txtPassword = _txtPassword;


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
       
    self.navigationController.navigationBarHidden = YES;
    [self.scrollView contentSizeToFit];
    self.btnShowPassword.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isLoggedIn = (BOOL)[defaults valueForKey:@"isLoggedIn"];
    
    if (isLoggedIn) {
        [self performSegueWithIdentifier:@"PushLoginToDashboard" sender:Nil];
    }
    else
    {
        self.txtUsername.text  = @"bhaveshporiya";
        self.txtPassword.text  = @"ecs@123";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

#pragma mark - Control Delegates

- (IBAction)btnRegisterClicked:(id)sender
{
    [self performSegueWithIdentifier:@"PushLoginToRegister" sender:Nil];
}

- (IBAction)btnLoginClicked:(id)sender
{
    [self.txtUsername resignFirstResponder];
    [self.txtPassword resignFirstResponder];

    if(![self.txtUsername.text isEqualToString:@""] && ![self.txtPassword.text isEqualToString:@""])
    {
        [self addOverLay];
        
        NSString *username = self.txtUsername.text;
        NSString *password = self.txtPassword.text;
        
       NSString *pushToken =  [[NSUserDefaults standardUserDefaults] valueForKey:kDeviceTokenKey];
        
        NSMutableURLRequest *_request;
        if(pushToken)
            _request= [CommanFunctions getLogInRequest:username Password:password pushToken:pushToken];
        else
            _request= [CommanFunctions getLogInRequest:username Password:password pushToken:@""];
        
        _request.timeoutInterval = 30;
        
        
        [NSURLConnection sendAsynchronousRequest:_request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 NSString *status = [[greeting objectForKey:@"data"]objectForKey:@"status"];
                 if([status isEqualToString:@"success"])
                 {
                     //{"action":"login","server":{"__comment":"Login","time":1414489492},"status":"success","data":{"Code":200,"message":"Login Successfully","UserID":"12"}}
                     
                     NSString *UID = [[greeting objectForKey:@"data"] objectForKey:@"UserID"];

                     
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     
                     [defaults setBool:YES forKey:@"isLoggedIn"];
                     [defaults setObject:UID forKey:@"UID"];
                     
                     [defaults synchronize];
                     

                     
                     [self performSegueWithIdentifier:@"PushLoginToDashboard" sender:Nil];
                 }
                 else
                 {
                     [self.txtUsername becomeFirstResponder];
                     
                     NSString *message = [[greeting objectForKey:@"data"] objectForKey:@"message"];
                     NSLog(@"%@",message);
                     
                     [self removeOverLay];
                     
                     UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Username or Password is invalid" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                     [failAlert show];
                     
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
        [self.txtUsername becomeFirstResponder];
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

- (IBAction)btnShowPasswordClicked:(id)sender {
    self.txtPassword.secureTextEntry = !self.txtPassword.secureTextEntry;
}



@end
