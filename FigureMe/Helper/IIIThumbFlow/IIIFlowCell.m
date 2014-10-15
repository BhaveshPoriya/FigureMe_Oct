//
//  IIIFlowCell.m
//  IIIThumbFlow
//
//  Created by sehone on 12/21/12.
//  Copyright (c) 2012 sehone <sehone@gmail.com>. All rights reserved.
//

#import "IIIFlowCell.h"
#import "UIImage+IIIThumb.h"

@interface IIIFlowCell () {
}

@end

static CGFloat _cellPadding;

@implementation IIIFlowCell
@synthesize reuseId = _reuseId;
@synthesize image = _image;

- (id)initWithReuseId:(NSString *)idStr
{
    self = [super init];
    if (self) {
        // Initialization code
        self.reuseId = idStr;
        _cellPadding = iii_const_common_cell_padding;
        //_cellPadding = 0;
        self.backgroundColor = iii_const_common_bg_color;
        //self.backgroundColor = [UIColor yellowColor];
        self.frame = CGRectZero;
        self.layer.cornerRadius = 5.0f;
    }
    return self;
}

- (void)loadWithImage:(UIImage *)image score:(NSInteger)Score cellWidth:(CGFloat)width {
    if (image) {
        // Set image view with thumb
        
        CGFloat imgWidth = width - _cellPadding * 2;
        CGFloat imgHeight = imgWidth * image.size.height / image.size.width;
        self.image = [[UIImageView alloc] initWithImage:image];
        self.image.frame = CGRectMake(_cellPadding, _cellPadding, imgWidth, imgHeight);
        
        self.image.layer.masksToBounds = YES;
        self.image.layer.cornerRadius = 5.0f;
        
        [self addSubview:self.image];
        
        self.scoreImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galler-scrore-count"]];
        
        self.scoreImage.frame = CGRectMake(self.image.frame.size.width-50, self.image.frame.size.height- 50,50, 50);
        
        [self.image addSubview:self.scoreImage];
        
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 36, 20, 15)];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)Score];
        self.scoreLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:9];
        self.scoreLabel.textColor= [UIColor whiteColor];
        
        [self.scoreImage addSubview:self.scoreLabel];

        
        CGRect rect = self.frame;
        rect.size.width = width;
        rect.size.height = imgHeight + _cellPadding * 2;
        self.frame = rect;
        
    } else {
        NSLog(@"image nil when load cell.");
    }
}




- (void)unload {
    // Unload thumb
    [self.image removeFromSuperview];
    self.image = nil;
}



@end
