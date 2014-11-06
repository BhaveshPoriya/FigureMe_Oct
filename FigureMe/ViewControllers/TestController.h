//
//  TestController.h
//  FigureMe
//
//  Created by ECSMac2 on 10/3/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "Constant.h"
#import "Test.h"
#import "DashboardController.h"

@interface TestController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>


@property (retain, nonatomic) Test *currentTest;
@property (nonatomic) NSInteger currentScore;
@property (nonatomic) NSInteger currentQuestionIndex;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewTestContainer;
@property (strong, nonatomic) IBOutlet UIView *viewTestPicContainer;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewTestPic;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPicBackground;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswer;

- (IBAction)btnFirstAnswerClicked:(id)sender;
- (IBAction)btnNextQuestionClicked:(id)sender;


@end
