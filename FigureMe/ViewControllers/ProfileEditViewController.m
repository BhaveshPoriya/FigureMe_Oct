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
        
        [self.imgViewProfile setImageWithURL:[NSURL URLWithString:self.objUserProfile.strProfilePic] placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
        self.imgViewProfile.layer.cornerRadius = self.self.imgViewProfile.frame.size.width / 2;
        self.imgViewProfile.clipsToBounds = YES;
        self.imgViewProfile.backgroundColor = [UIColor whiteColor];
        [self.imgViewProfile setContentMode:UIViewContentModeScaleAspectFill];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.scrollView contentSizeToFit];
}


- (IBAction)btnSaveProfileClicked:(id)sender {

    NSString *username = self.txtUsername.text;
    NSString *dob = self.txtDOB.text;
    NSString *interets = @"";
    NSString *location = [NSString stringWithFormat:@"%@,%@",self.txtCity.text,self.txtState.text];
    NSString *aboutme = self.txtViewAboutUs.text;
    NSString *profilePic = [CommanFunctions imageToBase64:self.imgUpdatedImage];
    
    
    NSMutableURLRequest *_request = [CommanFunctions getUpdateProfileRequest:@"12" userName:username DOB:dob interests:interets location:location aboutMe:aboutme profilePic:profilePic];
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
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
             else
             {
                 NSLog(@"updation failed");
             }
         }
     }];
}

- (IBAction)btnEditProfilePicClicked:(id)sender {
    
    
    UIActionSheet *popUpforImage = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"From Camera",
                                    @"From Gallery",
                                    nil];
    popUpforImage.tag = 2;
    [popUpforImage showInView:[UIApplication sharedApplication].keyWindow];
    
    
    
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
    
    self.viewCameraOverlay = [[UIView alloc] initWithFrame:self.view.frame];
    self.viewCameraOverlay.backgroundColor = [UIColor blackColor];
    self.viewCameraOverlay.alpha = 0.8f;
    [self.view addSubview:self.viewCameraOverlay];
    
    self.viewCameraContainer = [[UIView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, self.view.frame.size.height-30)];
    self.viewCameraContainer.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.viewCameraContainer];
    
    
    UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClick.frame = CGRectMake(15, 15, 25, 25);
    [btnClick addTarget:self
               action:@selector(capImage)
     forControlEvents:UIControlEventTouchUpInside];
    [btnClick setImage:[UIImage imageNamed:@"Camera-icon.png"] forState:UIControlStateNormal];
    [self.viewCameraContainer addSubview:btnClick];

    /*
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
     */
}

- (void) capImage
{
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
