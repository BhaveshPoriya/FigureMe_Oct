//
//  StatYourScore.m
//  FigureMe
//
//  Created by GauravPC on 10/10/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "StatYourScore.h"
#import "StatInfoCell.h"

@interface StatYourScore ()

@end

@implementation StatYourScore
@synthesize tblViewStatYourScore,btnInstanceHeadingStatYourScore;
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
    
    [self.tblViewStatYourScore reloadData];
    
    [self.btnInstanceHeadingStatYourScore setTitle:@"Most Known Friends First" forState:UIControlStateNormal];
    
    self.btnInstanceHeadingStatYourScore.titleLabel.font = [UIFont fontWithName:@"OpenSans-Regular" size:21];
    
    self.tblViewStatYourScore.layer.masksToBounds = YES;
    
    self.tblViewStatYourScore.layer.cornerRadius = 5.0f;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


{
    return 3;
    
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
    
    cell.imgviewStatInfoCell.image = [UIImage imageNamed:@"bgBump.png"];
    cell.lblNameStatInfoCell.text = @"Joe Handsome";
    cell.lblScoreStatInfoCell.text = @"120";
    
    
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

- (IBAction)btnActionHeadingStatYourScore:(id)sender {
}
@end
