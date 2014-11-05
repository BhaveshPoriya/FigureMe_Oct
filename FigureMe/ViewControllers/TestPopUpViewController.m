//
//  TestPopUpViewController.m
//  FigureMe
//
//  Created by bhavesh on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "TestPopUpViewController.h"

@interface TestPopUpViewController ()

@end

@implementation TestPopUpViewController

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
    
    self.lblTitle.font = [UIFont fontWithName:@"OpenSans-Light" size:25.0f];
    self.lblTitle.textColor = [UIColor whiteColor];
    
    self.viewTestPicContainer.layer.cornerRadius = self.viewTestPicContainer.frame.size.width / 2;
    self.viewTestPicContainer.clipsToBounds = YES;
    self.viewTestPicContainer.backgroundColor = [UIColor whiteColor];
    [self.viewTestPicContainer setContentMode:UIViewContentModeScaleAspectFill];
    
    //self.imgViewTestPic.image = [UIImage imageNamed:@"portrait_eyes_14.jpg"];
    NSURL *testImgURL = [NSURL URLWithString:self.currentTest.Test_picture];
    [self.imgViewTestPic setImageWithURL:testImgURL placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
    
    self.imgViewTestPic.layer.cornerRadius = self.imgViewTestPic.frame.size.width / 2;
    self.imgViewTestPic.clipsToBounds = YES;
    self.imgViewTestPic.backgroundColor = [UIColor whiteColor];
    [self.imgViewTestPic setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.view addSubview:self.viewTestOverViewContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftButtonClicked
{
    NSLog(@"leftButtonClicked");
}

- (IBAction)btnCloseTestClicked:(id)sender {
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    //UIViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"DashboardController"];
    //[(UINavigationController*)self.navigationController pushViewController:ivc animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnOpenTestClicked:(id)sender
{
    [self performSegueWithIdentifier:@"pushOpenTest" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TestController *_test = segue.destinationViewController;
    _test.currentTest = self.currentTest;
}
@end
