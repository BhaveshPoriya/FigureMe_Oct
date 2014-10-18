/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}


- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    UIImage *cachedImage = nil;
    if (url)
    {
        cachedImage = [manager imageWithURL:url];
    }

    if (cachedImage)
    {
        self.image = cachedImage;
    }
    else
    {
        if (placeholder)
        {
            self.image = placeholder;
        }

        if (url)
        {
            [manager downloadWithURL:url delegate:self];
        }
    }
}
/*
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [activity startAnimating];
    [activity setFrame:CGRectMake(self.frame.origin.x - 20, self.frame.origin.y - 10, self.frame.size.width, self.frame.size.height)];
    [self addSubview:activity];
    
    //[self setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
    
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:0
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
     {
         [activity removeFromSuperview];
     }];
}
*/
 
- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
}

@end
