//
//  NotificationTestCell.m
//  FigureMe
//
//  Created by GauravPC on 10/30/14.
//  Copyright (c) 2014 ECS. All rights reserved.
//

#import "NotificationTestCell.h"

@implementation NotificationTestCell
@synthesize primaryLabel,secondaryLabel,myImageView,button;

-(id)initWithNotification:(Notification *)Notiication reuseIdentifier:(NSString *)reuseIdentifier NotificationType:(NSString *)Type
//- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
       UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 292, 91)];
        backimage.image = [UIImage imageNamed:@"Notification-bg"];
        [self.contentView addSubview:backimage];
        [self.contentView sendSubviewToBack:backimage];
        
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = NSTextAlignmentLeft;
        //primaryLabel.font = [UIFont systemFontOfSize:14];
        primaryLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = NSTextAlignmentLeft;
       // secondaryLabel.font = [UIFont systemFontOfSize:8];
        secondaryLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:11];
        
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *buttonImage = [UIImage imageNamed:@"open-test-bg.png"];
        [button setTitle:@"OPEN TEST" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:11.0];       
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        myImageView = [[UIImageView alloc]init];
        
        
        
        
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:myImageView];
        [self.contentView addSubview:button];
        
                  
      
    }
    return self;
    
    
//    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
//        // Initialization code
//        primaryLabel = [[UILabel alloc]init];
//        primaryLabel.textAlignment = UITextAlignmentLeft;
//        primaryLabel.font = [UIFont systemFontOfSize:14];
//        secondaryLabel = [[UILabel alloc]init];
//        secondaryLabel.textAlignment = UITextAlignmentLeft;
//        secondaryLabel.font = [UIFont systemFontOfSize:8];
//        myImageView = [[UIImageView alloc]init];
//        [self.contentView addSubview:primaryLabel];
//        [self.contentView addSubview:secondaryLabel];
//        [self.contentView addSubview:myImageView];
//        
//    }
//    return self;

}
-(void)buttonTapped:(UIButton*)sender
{
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+15 ,13, 66, 66);
    myImageView.frame = frame;
    
    frame= CGRectMake(boundsX+100 ,20, 200, 12);
    primaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+100 ,38, 200, 12);
    secondaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+97 ,56, 83, 23);
    button.frame = frame;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
