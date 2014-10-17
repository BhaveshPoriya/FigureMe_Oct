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
    
    NSMutableURLRequest *_request = [CommanFunctions getGalleryRequest:@"12"];
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
                 
                 NSDictionary *dicGallery = [[greeting objectForKey:@"data"] objectForKey:@"galary"];
                 
                 for (NSDictionary *dicGalleryObject in dicGallery)
                 {
                     NSString *testPicUrl = [dicGalleryObject objectForKey:@"Test_picture"];
                     
                     IIIBaseData *d = [[IIIBaseData alloc] init];
                     d.score = [[dicGalleryObject objectForKey:@"Score"] integerValue];
                     d.web_url = testPicUrl;
                     
                     [self.dataSource addObject:d];

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
