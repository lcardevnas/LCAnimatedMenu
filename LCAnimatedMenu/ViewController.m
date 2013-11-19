//
//  ViewController.m
//  LCAnimatedMenu
//
//  Created by ThXou on 14/11/13.
//  Copyright (c) 2013 ThXou. All rights reserved.
//

#import "ViewController.h"
#import "LCMenuItem.h"
#import "LCAnimatedMenu.h"

@interface ViewController ()

@end



@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self addButtons];
    
    LCAnimatedMenu *menu = [[LCAnimatedMenu alloc] initWithFrame:CGRectZero];
    menu.containerView = self.view;

}


- (void)addItemWithEntranceAnimation:(UIView *)item withDelay:(NSTimeInterval)delay
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    NSArray *values = @[@(64), @(-10), @(10), @(0)];
    animation.values = values;
    
    NSArray *times = @[@(0.0), @(0.40), @(0.70), @(0.8)];
    animation.keyTimes = times;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.beginTime = CACurrentMediaTime() + delay;
    [item.layer addAnimation:animation forKey:@"Entrance"];
    
}


- (void)addButtons
{
    CGRect positionFrame = CGRectMake(self.view.bounds.size.width - 64, self.view.bounds.size.height - 64, 50, 50);
    LCMenuItem *item1 = [[LCMenuItem alloc] initWithFrame:positionFrame];
    [self.view addSubview:item1];
    
    [self addItemWithEntranceAnimation:item1 withDelay:0.3];
    
    positionFrame = CGRectMake(self.view.bounds.size.width - 128, self.view.bounds.size.height - 64, 50, 50);
    LCMenuItem *item2 = [[LCMenuItem alloc] initWithFrame:positionFrame];
    [self.view addSubview:item2];
    
    [self addItemWithEntranceAnimation:item2 withDelay:0.8];
}


- (IBAction)fire:(id)sender
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isMemberOfClass:NSClassFromString(@"LCMenuItem")])
        {
            [view removeFromSuperview];
        }
    }
    
    [self addButtons];
}




@end
