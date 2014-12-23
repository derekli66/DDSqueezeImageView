//
//  DDSwitchImageView.m
//  ObjectiveCPractice
//
//  Created by LEE CHIEN-MING on 10/9/14.
//  Copyright (c) 2014 Derek. All rights reserved.
//

#import "DDSqueezeImageView.h"

static CGAffineTransform MinimumTransform(void) {
    CGFloat minimumSize = 0.00001f; // change mimimum here
    return CGAffineTransformMakeScale(minimumSize, minimumSize);
}

static CGAffineTransform OversizeTransform(void) {
    CGFloat oversize = 1.3f; // change oversize here
    return CGAffineTransformScale(CGAffineTransformIdentity, oversize, oversize);
}

static dispatch_source_t CreateDispatchTimer(NSTimeInterval interval, NSTimeInterval leeway, dispatch_block_t block){
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    int64_t delay_ = interval * NSEC_PER_SEC;
    int64_t leeway_ = leeway * NSEC_PER_SEC;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, delay_ , leeway_);
    
    dispatch_source_set_event_handler(timer, block);
    dispatch_resume(timer);
    
    return timer;
}

@interface DDSqueezeImageView ()
@property (nonatomic) dispatch_source_t backgroundTimerSource;
@end

@implementation DDSqueezeImageView
- (void)switchImage:(BOOL)animated
{
    if (!self.highlightedImage) {
        self.highlightedImage = self.image;
    }
    
    if (!animated) {
        self.highlighted = !self.highlighted;
        return;
    }
    
    // Squeez current transform to minimized tranform
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = MinimumTransform();
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.highlighted = !self.highlighted;
                             
                             // Enlarge transform to oversize
                             [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  self.transform = OversizeTransform();
                                              }
                                              completion:^(BOOL finished) {
                                                  // Bouncing back
                                                  if (finished) {
                                                      [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut
                                                                       animations:^{
                                                                           self.transform = CGAffineTransformIdentity;
                                                                       }
                                                                       completion:nil];
                                                  }
                                              }];
                         }
                     }];
}

- (void)autoSwitchingWithInterval:(NSTimeInterval)anInterval
{
    if (self.backgroundTimerSource) {
        return;
    }
    
    dispatch_source_t newTimer = CreateDispatchTimer(anInterval, 0.0,  ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self switchImage:YES];
        });
    });
    
    self.backgroundTimerSource = newTimer;
}

- (void)stopAutoSwitching
{
    if (!self.backgroundTimerSource) {
        return;
    }
    
    dispatch_source_cancel(self.backgroundTimerSource);
    self.backgroundTimerSource = nil;
}

@end
