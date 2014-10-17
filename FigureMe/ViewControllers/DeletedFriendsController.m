//
//  DeletedFriendsController.m
//  FigureMe
//
//  Created by GauravPC on 10/14/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "DeletedFriendsController.h"

@interface DeletedFriendsController ()

@end

@implementation DeletedFriendsController
@synthesize tabbarDeletedFriends;
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
    
    
    
    UIImage *unselectedImage = [[UIImage imageNamed:@"Iphone-deleted-friends.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarDeletedFriends.selectedImage = unselectedImage;
    
    
    UIImage *selectedImage = [[UIImage imageNamed:@"Iphone-deleted-friends-hover.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarDeletedFriends.selectedImage = selectedImage;
    
    [tabbarDeletedFriends setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabbarDeletedFriends setSelectedImage: selectedImage];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
