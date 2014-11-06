//
//  ResultView.m
//  FigureMe
//
//  Created by bhavesh on 11/5/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithResult: (Result *)result
{
    CGRect frame = [[[UIApplication sharedApplication] keyWindow] bounds];
;
    self = [super initWithFrame: frame];
    if (!self)
        return nil;

    self.frame = frame;
    UIColor *customColor = [UIColor colorWithRed:214./255. green:214./255. blue:214./255. alpha:1];
    UIColor *nameLabelColor = [UIColor colorWithRed:107./255. green:159./255. blue:97./255. alpha:1];

    UIView *viewBackgroundOverlay = [[UIView alloc] initWithFrame:frame];
    viewBackgroundOverlay.backgroundColor = [UIColor blackColor];
    viewBackgroundOverlay.alpha = 0.7f;
    [self addSubview:viewBackgroundOverlay];

    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    [viewBackgroundOverlay addGestureRecognizer:letterTapRecognizer];
    
    UIView *viewResultContainer = [[UIView alloc] initWithFrame:CGRectMake(25, 150, 270, 350)];
    viewResultContainer.layer.cornerRadius = 20;
    viewResultContainer.backgroundColor = customColor;
    [self addSubview:viewResultContainer];

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewResultContainer.frame.size.width, 50)];
    header.backgroundColor = [UIColor blackColor];
    header.alpha = 0.3f;
    [viewResultContainer addSubview:header];
    
    UILabel *lblHeaderText = [[UILabel alloc] initWithFrame:header.frame];
    lblHeaderText.textAlignment = NSTextAlignmentCenter;
    lblHeaderText.text = @"Result";
    lblHeaderText.font = [UIFont fontWithName:@"OpenSans-Semibold" size:22];
    [viewResultContainer addSubview:lblHeaderText];

    UIView *viewTestPicContainer = [[UIImageView alloc] initWithFrame:CGRectMake(55, 68, 159, 159)];
    viewTestPicContainer.layer.cornerRadius = viewTestPicContainer.frame.size.width / 2;
    viewTestPicContainer.clipsToBounds = YES;
    viewTestPicContainer.backgroundColor = [UIColor whiteColor];
    [viewTestPicContainer setContentMode:UIViewContentModeScaleAspectFill];

    UIImageView *imgViewTestPic = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 155, 155)];
    [imgViewTestPic setImageWithURL:[NSURL URLWithString:result.Test_picture] placeholderImage:[UIImage imageNamed:@"anon.jpg"]];
    imgViewTestPic.layer.cornerRadius = imgViewTestPic.frame.size.width / 2;
    imgViewTestPic.clipsToBounds = YES;
    [imgViewTestPic setContentMode:UIViewContentModeScaleAspectFill];
    [viewTestPicContainer addSubview:imgViewTestPic];
    
    [viewResultContainer addSubview:viewTestPicContainer];
    
    UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, viewResultContainer.frame.size.width, 50)];
    lblname.textAlignment = NSTextAlignmentCenter;
    lblname.textColor = nameLabelColor;
    lblname.text = result.Name;
    lblname.font = [UIFont fontWithName:@"OpenSans-Light" size:25];
    [viewResultContainer addSubview:lblname];

    
    UILabel *lblscore = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, viewResultContainer.frame.size.width, 50)];
    lblscore.textAlignment = NSTextAlignmentCenter;
    lblscore.text = [NSString stringWithFormat:@"Your Score: %@",result.Score];
    lblscore.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
    [viewResultContainer addSubview:lblscore];
    
    self.alpha = 0;
    return  self;
}

- (void)highlightLetter:(UITapGestureRecognizer*)sender {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
