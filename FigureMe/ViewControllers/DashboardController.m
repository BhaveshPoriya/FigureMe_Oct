//
//  DashboardController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/2/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "DashboardController.h"

@interface DashboardController ()

@end

@implementation DashboardController

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
    self.navigationController.navigationBarHidden = NO;
    
    CGRect f;
    if(IS_IPHONE)
        f = CGRectMake(10, 105, 300, 450);
    else if(IS_IPAD)
        f =CGRectMake(10, 105, 750, 900);
    self.galleryFlowview = [[IIIFlowView alloc] initWithFrame:f];
    self.galleryFlowview.flowDelegate = self;
    
    //Dressing up the view
    self.galleryFlowview.layer.cornerRadius = 10.0f;
    
    [self.galleryFlowview.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.galleryFlowview.layer setShadowOpacity:0.8];
    [self.galleryFlowview.layer setShadowRadius:10.0];
    [self.galleryFlowview.layer setShadowOffset:CGSizeMake(5.0, 5.0)];

    [self addOverLay];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString*UID=[defaults objectForKey:@"UID"];
    
    NSMutableURLRequest *_request = [CommanFunctions getGalleryRequest:UID];
    _request.timeoutInterval = 30;
    
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
             {
                 [self removeOverLay];

                 self.dataSource = [NSMutableArray arrayWithCapacity:0];
                 self.results = [NSMutableArray arrayWithCapacity:0];

                 
                 NSDictionary *dicGallery = [[greeting objectForKey:@"data"] objectForKey:@"gallary"];
                 int count=1;
                 for (NSDictionary *dicGalleryObject in dicGallery)
                 {
                     if(count<=8)
                     {
                         count++;
                         
                         Result *result = [Result new];
                         result.TestID = [dicGalleryObject objectForKey:@"TestID"];
                         result.UserID = [dicGalleryObject objectForKey:@"UserID"];
                         result.Name = [dicGalleryObject objectForKey:@"Name"];
                         result.Score = [dicGalleryObject objectForKey:@"Score"];
                         result.Test_picture = [dicGalleryObject objectForKey:@"Test_picture"];
                         [self.results addObject:result];

                         NSString *testPicUrl = result.Test_picture;
                         IIIBaseData *d = [[IIIBaseData alloc] init];
                         d.score = [result.Score integerValue];
                         d.web_url = testPicUrl;
                         [self.dataSource addObject:d];
                     }
                     else
                         break;
                 }
                 
                 [self.galleryFlowview reloadData];
                 
                 self.galleryFlowview.tag = 1001;
                 
                 [self.view addSubview:self.galleryFlowview];
             }
             else
             {
                 
                 NSString *message = [[greeting objectForKey:@"data"] objectForKey:@"message"];
                 NSLog(@"%@",message);
                 
                 [self removeOverLay];
                 
                 UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Server is unavaiable" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                 [failAlert show];
                 
             }
         }
         else
         {
             [self removeOverLay];
         }
     }];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showRightMenuPressed:(id)sender {
}

- (IBAction)btnSeeAllClicked:(id)sender {
    [self performSegueWithIdentifier:@"PushDashboardToGallery" sender:self];
}

- (IBAction)btnPushItClicked:(id)sender {
    
    NSString *testID = @"33";
    
    NSMutableURLRequest *_request = [CommanFunctions getTest:testID];
    _request.timeoutInterval = 30;
    
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
             if([status isEqualToString:@"success"])
             {
                 //id<UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
                 NSDictionary *testDict = [[greeting objectForKey:@"data"] objectForKey:@"test"];

                 Test *currentTest = [Test new];
                 currentTest.TestID = [testDict objectForKey:@"TestID"];
                 currentTest.Name = [testDict objectForKey:@"Name"];
                 currentTest.Test_picture = [testDict objectForKey:@"Test_picture"];

                 NSArray *Questions = [[testDict objectForKey:@"Questions"] componentsSeparatedByString:@","];
                 NSArray *Answers = [[testDict objectForKey:@"Answers"] componentsSeparatedByString:@","];
                 NSInteger numberOfQuestions = Answers.count;
                 NSInteger pointsPerQuestion = (NSInteger)200/numberOfQuestions;
                 
                 currentTest.Questions = [[NSMutableArray alloc] init];
                 for (int i=0;i<numberOfQuestions;i++) {
                     Question *tempQue= [Question new];
                     tempQue.Question = [Questions objectAtIndex:i];
                     tempQue.Answer = [Answers objectAtIndex:i];
                     tempQue.Points = pointsPerQuestion;
                     [currentTest.Questions addObject:tempQue];
                 }
                 
                 
                 CATransition* transition = [CATransition animation];
                 transition.duration = 0.5;
                 transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                 transition.type = kCATransitionFade;
                 [self.navigationController.view.layer addAnimation:transition forKey:nil];
                 
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                 TestPopUpViewController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"TestPopUpViewController"];
                 ivc.currentTest = currentTest;
                 [(UINavigationController*)self.navigationController pushViewController:ivc animated:NO];
                 
                 //UIWindow* window = [[UIApplication sharedApplication] keyWindow];
                 //TestPopUpViewController *testObj = [[TestPopUpViewController alloc] init];
                 //[window addSubview:testObj.view];
             }
             else
             {
                 
                 NSString *message = [[greeting objectForKey:@"data"] objectForKey:@"message"];
                 NSLog(@"%@",message);
                 
                 UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Server is unavaiable" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                 [failAlert show];
                 
             }
         }
         else
         {
             [self removeOverLay];
         }
     }];
    
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

#pragma mark - IIIFlowView delegate required methods

- (void)didSelectCellAtIndex:(int)index
{
    Result *result = [self.results objectAtIndex:index];
    ResultView *view = [[ResultView alloc] initWithResult:result];
    [self.view addSubview:view];
    
    [UIView animateWithDuration:0.3f animations:^{
        view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (NSInteger)numberOfColumns {
    return 2;
}


- (NSInteger)numberOfCells
{
    if(self.dataSource.count <= 8)
        return self.dataSource.count;
    else
        return 8;
}


- (CGFloat)rateOfCache {
    return 5.0f;
}


- (IIIFlowCell *)flowView:(IIIFlowView *)flow cellAtIndex:(int)index {
    NSString *reuseId = @"CommonCell";
    IIIFlowCell *cell = [flow dequeueReusableCellWithId:reuseId];
    if (!cell) {
        cell = [[IIIFlowCell alloc] initWithReuseId:reuseId];
    }
    return cell;
}

- (IIIBaseData *)dataSourceAtIndex:(int)index {
    return [self.dataSource objectAtIndex:index];
}

@end
