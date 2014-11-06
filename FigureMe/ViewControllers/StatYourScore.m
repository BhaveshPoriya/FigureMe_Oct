//
//  StatYourScore.m
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "StatYourScore.h"
#import "StatInfoCell.h"
#import "CommanFunctions.h"
#import "Score.h"
@interface StatYourScore ()
{
    NSMutableArray *arrScores;
}
@end

@implementation StatYourScore
@synthesize tblViewStatYourScore,btnInstanceHeadingStatYourScore,tabbarItemScore;
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
    
    NSMutableURLRequest *_request = [CommanFunctions getScoreRequest:@"12"];
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
                 arrScores = [[NSMutableArray alloc]init];
                 NSDictionary *scores = [[greeting objectForKey:@"data"] objectForKey:@"score"];
                 
                 for(NSDictionary *_Score in scores)
                     
                 {
                    // NSDictionary *tempDist = [scores objectForKey:_Score];
                     
                     Score *scoreDetail = [[Score alloc]init];
                     
                     
                     NSString *strScore = [NSString stringWithFormat:@"%@",[_Score objectForKey:@"Score"]];
                     scoreDetail.Score = strScore;
                     scoreDetail.Name = [_Score objectForKey:@"Name"];
                     scoreDetail.image = [_Score objectForKey:@"Test_picture"];
                     [arrScores addObject:scoreDetail];
                     
                     
                 }
                 
                 [self.tblViewStatYourScore reloadData];
             }
             
             
         }
     }];
    
    [self.btnInstanceHeadingStatYourScore setTitle:@"Most Known Friends First" forState:UIControlStateNormal];
    
    self.btnInstanceHeadingStatYourScore.titleLabel.font = [UIFont fontWithName:@"OpenSans-Regular" size:21];
    
    self.tblViewStatYourScore.layer.masksToBounds = YES;
    
    self.tblViewStatYourScore.layer.cornerRadius = 5.0f;
    
    
    
    
    UIImage *unselectedImage = [[UIImage imageNamed:@"score.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItemScore.selectedImage = unselectedImage;
    
    
    UIImage *selectedImage = [[UIImage imageNamed:@"score.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItemScore.selectedImage = selectedImage;
    
    [tabbarItemScore setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabbarItemScore setSelectedImage: selectedImage];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(arrScores.count > 10)
        tableView.scrollEnabled = YES;
    else
        tableView.scrollEnabled = NO;
     return arrScores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"StatCustomCell";
    
    StatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[StatInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   
    
    Score *score = [arrScores objectAtIndex:indexPath.row];
    
    NSString *strImageUrl = score.image;
    
    NSURL *urlStatImage = [NSURL URLWithString:strImageUrl];
    [cell.imgviewStatInfoCell setImageWithURL:urlStatImage placeholderImage:[UIImage imageNamed:@"bgBump.png"]];
    
    
    cell.lblNameStatInfoCell.text = score.Name;
    cell.lblScoreStatInfoCell.text = score.Score;
    
    
    
    [cell.lblNameStatInfoCell setFont:[UIFont fontWithName:@"OpenSans-Light" size:14.0]];
    [cell.lblScoreStatInfoCell setFont:[UIFont fontWithName:@"OpenSans-Light" size:14.0]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btnDeleteInstanceStatInfoCell.tag = indexPath.row;
    [cell.btnDeleteInstanceStatInfoCell addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;

    
    
}


-(void)yourButtonClicked:(UIButton*)sender
{
    NSLog(@"button tapped Index %d",sender.tag);
    //here you get its each button action you can identirire which button click by its tag
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnActionHeadingStatYourScore:(id)sender
{
    NSLog(@"button tapped Index %@",sender);
}
@end
