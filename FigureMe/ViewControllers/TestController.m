//
//  TestController.m
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "TestController.h"

@interface TestController ()

@end

@implementation TestController

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
    
    [self.scrollView contentSizeToFit];
    
    self.lblQuestion.font = [UIFont fontWithName:@"OpenSans-Light" size:16];
    
    self.currentScore = 0;
    self.currentQuestionIndex = 0;
    
    self.viewTestContainer.layer.cornerRadius = 20;
    
    self.viewTestPicContainer.layer.cornerRadius = self.viewTestPicContainer.frame.size.width / 2;
    self.viewTestPicContainer.clipsToBounds = YES;
    self.viewTestPicContainer.backgroundColor = [UIColor whiteColor];
    [self.viewTestPicContainer setContentMode:UIViewContentModeScaleAspectFill];
    
    NSURL *testImgURL = [NSURL URLWithString:self.currentTest.Test_picture];
    [self.imgViewTestPic setImageWithURL:testImgURL placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
    
    self.imgViewTestPic.layer.cornerRadius = self.imgViewTestPic.frame.size.width / 2;
    self.imgViewTestPic.clipsToBounds = YES;
    self.imgViewTestPic.backgroundColor = [UIColor whiteColor];
    [self.imgViewTestPic setContentMode:UIViewContentModeScaleAspectFill];
    
    [self performSelector:@selector(animateButtons) withObject:nil afterDelay:0.1f];
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.75;
    [self.lblQuestion.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
}

- (void)animateButtons {
    
    [UIView animateWithDuration:0.5f animations:^{
        for (UIView *view in self.viewTestContainer.subviews) {
            switch (view.tag) {
                case 201:
                    view.center = CGPointMake(148, 52);
                    break;
                case 202:
                    view.center = CGPointMake(237, 108);
                    break;
                case 203:
                    view.center = CGPointMake(237, 198);
                    break;
                case 204:
                    view.center = CGPointMake(148, 255);
                    break;
                case 205:
                    view.center = CGPointMake(52, 198);
                    break;
                case 206:
                    view.center = CGPointMake(52, 108);
                    break;
            }
        }
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFirstAnswerClicked:(id)sender {
    Question *que =[self.currentTest.Questions objectAtIndex:0];
    NSString *correctAnswer = [que.Answer lowercaseString];
    
    NSString *useranswer;
    
    UIButton *tempButton = (UIButton*)sender;
    switch (tempButton.tag) {
        case 201:
            useranswer = @"facebook";
            break;
        case 202:
            useranswer = @"twitter";
            break;
        case 203:
            useranswer = @"youtube";
            break;
        case 204:
            useranswer = @"instagram";
            break;
        case 205:
            useranswer = @"googleplus";
            break;
        case 206:
            useranswer = @"linkedin";
            break;
    }
    
    CGFloat result = [correctAnswer scoreAgainst:useranswer fuzziness:[NSNumber numberWithFloat:0.8]];
    
    if(result>=0.60)
    {
        self.currentScore +=que.Points;
    }
    [self btnNextQuestionClicked:sender];
}

- (IBAction)btnNextQuestionClicked:(id)sender {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.lblQuestion.layer addAnimation:animation forKey:@"changeTextTransition"];
    
    if(self.currentQuestionIndex < self.currentTest.Questions.count-1)
    {
        if(self.currentQuestionIndex == 0)
        {
            CGPoint newLeftCenter = CGPointMake( 127, 130);
            [UIView animateWithDuration:0.5f animations:^{
                for (UIView *view in self.viewTestContainer.subviews) {
                    if (view.tag == 201 || view.tag == 202 || view.tag == 203 || view.tag == 204 || view.tag == 205 || view.    tag == 206) {
                        view.center = newLeftCenter;
                    }
                }
                self.imgViewPicBackground.center = CGPointMake(self.imgViewPicBackground.center.x, self.imgViewPicBackground.center.y-10);
                self.viewTestPicContainer.center = CGPointMake(self.viewTestPicContainer.center.x, self.viewTestPicContainer.center.y-10);
                self.lblQuestion.center = CGPointMake(self.lblQuestion.center.x, self.lblQuestion.center.y-30);
                self.txtAnswer.alpha = 1.0f;
                
            } completion:nil];
        }
        
        Question *prevQue =[self.currentTest.Questions objectAtIndex:self.currentQuestionIndex];
        NSString *correctAnswer = [prevQue.Answer lowercaseString];
        NSString *userAnser = [self.txtAnswer.text lowercaseString];
        
        CGFloat result = [correctAnswer scoreAgainst:userAnser fuzziness:[NSNumber numberWithFloat:0.8]];
        
        if(result>=0.60)
        {
            self.currentScore +=prevQue.Points;
        }
        self.txtAnswer.text = @"";
        
        self.currentQuestionIndex+=1;
        Question *tempQue =[self.currentTest.Questions objectAtIndex:self.currentQuestionIndex];
        self.lblQuestion.text = tempQue.Question;
    }
    else
    {
        if(self.currentQuestionIndex == self.currentTest.Questions.count-1)
        {
            Question *prevQue =[self.currentTest.Questions objectAtIndex:self.currentQuestionIndex];
            NSString *correctAnswer = [prevQue.Answer lowercaseString];
            NSString *userAnser = [self.txtAnswer.text lowercaseString];
            
            CGFloat result = [correctAnswer scoreAgainst:userAnser fuzziness:[NSNumber numberWithFloat:0.8]];
            
            if(result>=0.60)
            {
                self.currentScore +=prevQue.Points;
            }
            self.txtAnswer.text = @"";
            self.lblQuestion.text = @"A photo can tell million things, What you think of this profile?";
            
            self.currentQuestionIndex+=1;
        }
        else
        {
            UIView *viewLoadingOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewTestContainer.frame.size.width, self.viewTestContainer.frame.size.height)];
            viewLoadingOverlay.layer.cornerRadius = 20;
            viewLoadingOverlay.backgroundColor = [UIColor blackColor];
            viewLoadingOverlay.alpha = 0.3f;
            
            UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            activity.frame = CGRectMake((viewLoadingOverlay.frame.size.width/2) - 10 , (viewLoadingOverlay.frame.size.height/2) - 10, 10, 10);
            [activity startAnimating];
            [viewLoadingOverlay addSubview:activity];
            
            [self.viewTestContainer addSubview:viewLoadingOverlay];
            
            NSString *strscore = [NSString stringWithFormat:@"%ld",(long)self.currentScore];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString*UID=[defaults objectForKey:@"UID"];

            NSMutableURLRequest *_request = [CommanFunctions submitTest:UID TestId:self.currentTest.TestID Score:strscore];
            _request.timeoutInterval = 30;

            [NSURLConnection sendAsynchronousRequest:_request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                 DashboardController *ivc = [storyboard instantiateViewControllerWithIdentifier:@"DashboardController"];
                 [(UINavigationController*)self.navigationController pushViewController:ivc animated:NO];
                 
                 if (data.length > 0 && connectionError == nil)
                 {
                     NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     NSString *status = [[greeting objectForKey:@"data"] objectForKey:@"status"];
                     if([status isEqualToString:@"success"])
                     {
                        //UIAlertView *score = [[UIAlertView alloc] initWithTitle:@"" message:strscore delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil , nil];
                        //[score show];
                     }
                     else
                     {
                     }
                 }
                 else
                 {
                 }
             }];
        }
    }
    [self.txtAnswer resignFirstResponder];
}

#pragma mark - UITextFieldDelegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - UIAlertViewDelegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
}
@end
