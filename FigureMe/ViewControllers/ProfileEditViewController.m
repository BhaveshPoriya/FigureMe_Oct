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
	// Do any additional setup after loading the view.
    
    if(self.objUserProfile)
    {
        self.txtUsername.text = self.objUserProfile.strUserName;
        self.txtDOB.text = self.objUserProfile.strDOB;
        self.txtCity.text = self.objUserProfile.strLocationCity;
        self.txtState.text = self.objUserProfile.strLocationState;
        self.txtViewAboutUs.text = self.objUserProfile.strAboutMe;
        
        self.txtViewAboutUs.editable = YES;
        self.txtViewAboutUs.layer.cornerRadius = 10;
        self.txtViewAboutUs.layer.borderColor = [[UIColor grayColor] CGColor];
        self.txtViewAboutUs.layer.borderWidth = 1;
        
        self.txtDOB.inputView = self.customInput;
        self.txtDOB.inputAccessoryView = self.accessoryView;
        
        [self.imgViewProfile setImageWithURL:[NSURL URLWithString:self.objUserProfile.strProfilePic] placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
        self.imgViewProfile.layer.cornerRadius = self.self.imgViewProfile.frame.size.width / 2;
        self.imgViewProfile.clipsToBounds = YES;
        self.imgViewProfile.backgroundColor = [UIColor whiteColor];
        [self.imgViewProfile setContentMode:UIViewContentModeScaleAspectFill];
        
       AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:10];
        self.checkboxes = a;
        
        SSCheckBoxView *cbv = nil;
        CGRect frame = CGRectMake(5, 5, 150, 30);
        
        self.scrollViewInterest.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        self.scrollViewInterest.layer.cornerRadius = 3.0f;
        
        for (int i = 0; i < mainDelegate.sharedArray.count; ++i) {
            
            SSCheckBoxViewStyle style = 1;
            NSString *intsText = [mainDelegate.sharedArray objectAtIndex:i];
            
            BOOL checked = NO;
            if([self.objUserProfile.strInterest rangeOfString:intsText].location == NSNotFound)
                checked = NO;
            else
                checked = YES;

            cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                                  style:style
                                                checked:checked];
            
            [cbv setText:intsText];
            
            [self.scrollViewInterest addSubview:cbv];
            [self.checkboxes addObject:cbv];
            
            float newHeight = self.scrollViewInterest.contentSize.height+17;
            self.scrollViewInterest.contentSize = CGSizeMake(frame.size.width, newHeight);
            frame.origin.y += 20;
        
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kTwitterTokenKey])
        self.btnTwitter.imageView.image = [UIImage imageNamed:@"twitter-g"];
    else
        self.btnTwitter.imageView.image = [UIImage imageNamed:@"twitter"];
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kFacebookTokenKey])
        self.btnFacebook.imageView.image = [UIImage imageNamed:@"facebook-g"];
    else
        self.btnFacebook.imageView.image = [UIImage imageNamed:@"facebook"];
    
    
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

}

- (void)viewDidLayoutSubviews
{
    self.scrollViewInterest.contentSize = self.scrollViewInterest.contentSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.scrollView contentSizeToFit];
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

- (IBAction)btnSaveProfileClicked:(id)sender {

    NSString *username = [self.txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dob = self.txtDOB.text;
    NSString *location = [NSString stringWithFormat:@"%@,%@",[self.txtCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],[self.txtState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    NSString *aboutme = self.txtViewAboutUs.text;
    
    if(![username isEqualToString:@""])
    {
    
    [self addOverLay];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    NSString *interests = @"";
    for (SSCheckBoxView *tempCheckbox in self.checkboxes) {
        if(tempCheckbox.checked)
            interests = [NSString stringWithFormat:@"%@,%@",interests,tempCheckbox.textLabel.text];
    }
    
    NSString *profilePic = [CommanFunctions imageToBase64:self.imgUpdatedImage];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString*UID=[defaults objectForKey:@"UID"];
    NSMutableURLRequest *_request = [CommanFunctions getUpdateProfileRequest:UID userName:username DOB:dob interests:interests location:location aboutMe:aboutme profilePic:profilePic];
    _request.timeoutInterval = 120;
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
        [self.navigationItem setHidesBackButton:NO animated:YES];
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting  objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
             {
                 NSArray *viewControllers = self.navigationController.viewControllers;
                 ProfileController *profileControllerObject = [viewControllers objectAtIndex:viewControllers.count -2];
                 profileControllerObject.updatedImage = self.imgUpdatedImage;
                 
                 [self removeOverLay];
                 
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
             else
             {
                 NSLog(@"updation failed");
             }
         }
     }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Username cannot be blank" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:Nil, nil];
        [alert show];
        [self.txtUsername becomeFirstResponder];
    }
}


- (IBAction)btnEditProfilePicClicked:(id)sender {
    
    
    UIActionSheet *popUpforImage = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"From Camera",
                                    @"From Gallery",
                                    nil];
    popUpforImage.tag = 2;
    [popUpforImage showInView:[UIApplication sharedApplication].keyWindow];
    
    
    
}

- (IBAction)dateChanged:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    self.txtDOB.text = [NSString stringWithFormat:@"%@", picker.date];
}

- (IBAction)doneEditing:(id)sender {
    [self.txtDOB resignFirstResponder];
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

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.txtDOB])
    {
        self.customInput = [[UIDatePicker alloc] init];
        self.customInput.datePickerMode = UIDatePickerModeDate;
        self.customInput.maximumDate = [NSDate date];
        [self.customInput addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        textField.inputView = self.customInput;

        if(![self.objUserProfile.strDOB isEqualToString:@"Unavailable"])
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMM, yyyy"];
            NSDate *dob = [formatter dateFromString:self.objUserProfile.strDOB];
            [self.customInput setDate:dob animated:YES];
        }
        
        self.accessoryView= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        [self.accessoryView setBarStyle:UIBarStyleBlackOpaque];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(changeDateFromLabel:)];
        self.accessoryView.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
        barButtonDone.tintColor=[UIColor blackColor];
        
        self.txtDOB.inputAccessoryView = self.accessoryView;
    }
}

-(void) datePickerValueChanged:(id)sender {
    UIDatePicker *temp = (UIDatePicker*)sender;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:temp.date];
    self.txtDOB.text = stringFromDate;
}

-(void)changeDateFromLabel:(id)sender
{
    [self.txtDOB resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIActionSheet Delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(actionSheet.tag == 2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        switch (buttonIndex) {
            case 0:
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //self.btnFlash.enabled = YES;
                //self.btnCamera.enabled = YES;
                [self initializeCamera];
                break;
            case 1:
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:picker animated:YES completion:NULL];
                break;
        }
    }
}

#pragma mark -  imagePickerController Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectedImage =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.imgUpdatedImage = selectedImage;
    [self.imgViewProfile setImage:selectedImage];
    self.imgViewProfile.layer.cornerRadius = self.self.imgViewProfile.frame.size.width / 2;
    self.imgViewProfile.clipsToBounds = YES;
    self.imgViewProfile.backgroundColor = [UIColor whiteColor];
    [self.imgViewProfile setContentMode:UIViewContentModeScaleAspectFill];
}

#pragma mark - LiveCamDelegates

- (void) initializeCamera
{
    self.navigationController.navigationBarHidden = YES;
    self.viewCameraOverlay = [[UIView alloc] initWithFrame:self.view.frame];
    self.viewCameraOverlay.backgroundColor = [UIColor blackColor];
    self.viewCameraOverlay.alpha = 0.8f;
    [self.view addSubview:self.viewCameraOverlay];
    
    self.viewCameraContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //self.viewCameraContainer.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.viewCameraContainer];
    
    
    self.session = [[AVCaptureSession alloc] init];
	self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
	self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
	self.viewCameraContainer.frame = self.viewCameraContainer.bounds;
	[self.viewCameraContainer.layer addSublayer:self.captureVideoPreviewLayer];
    
    UIView *view = self.viewCameraContainer;
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [self.captureVideoPreviewLayer setFrame:bounds];
    
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *backCamera;
    
    for (AVCaptureDevice *device in devices) {
        
        NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                backCamera = device;
            }
        }
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if (!input) {
        NSLog(@"ERROR: trying to open camera: %@", error);
    }
    
    [self.session addInput:input];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [self.session addOutput:self.stillImageOutput];
    
	[self.session startRunning];
    
    //self.isCameraActive = YES;
    
    UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClick.frame = CGRectMake(125, 490, 70, 70);
    [btnClick addTarget:self
                 action:@selector(capImage)
       forControlEvents:UIControlEventTouchUpInside];
    [btnClick setImage:[UIImage imageNamed:@"Camera-icon.png"] forState:UIControlStateNormal];
    [self.viewCameraContainer addSubview:btnClick];
}

- (void) capImage
{
    self.navigationController.navigationBarHidden = NO;
    [self.viewCameraOverlay removeFromSuperview];
    [self.viewCameraContainer removeFromSuperview];
    
    //method to capture image from AVCaptureSession video feed
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", self.stillImageOutput);
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            UIImage *capturedImage = [UIImage imageWithData:imageData];
            self.imgUpdatedImage = capturedImage;
            [self.imgViewProfile setImage:capturedImage];
            self.imgViewProfile.layer.cornerRadius = self.self.imgViewProfile.frame.size.width / 2;
            self.imgViewProfile.clipsToBounds = YES;
            self.imgViewProfile.backgroundColor = [UIColor whiteColor];
            [self.imgViewProfile setContentMode:UIViewContentModeScaleAspectFill];
        }
    }];
}

@end
