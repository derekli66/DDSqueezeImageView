//
//  DDSwitchImageView.h
//  ObjectiveCPractice
//
//  Created by LEE CHIEN-MING on 10/9/14.
//  Copyright (c) 2014 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>

/** DDSwitchImageView will switch image and highlight image with -switchImage method
 
 1. Set image and hightlight image before switching. If no highlight image, the highlight image
    will be set with image from image property
 
 2. -switchImage method will run scaling animation to switch image and highlight image
 
 */
@interface DDSqueezeImageView : UIImageView
/**
 Switching UIImageView's image and highlight image with a squeeze animation
 
 @param animated Yes or No for animation trigger
 */
- (void)switchImage:(BOOL)animated;

/**
 Auto switching with a specified interval
 
 @param anInterval an interval for auto switching
 */
- (void)autoSwitchingWithInterval:(NSTimeInterval)anInterval;

/**
 Stop auto switching
 */
- (void)stopAutoSwitching;
@end
