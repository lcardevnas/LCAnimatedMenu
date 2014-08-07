//
//  ViewController.m
//  LCAnimatedMenu
//
//  Created by ThXou on 14/11/13.
//  Copyright (c) 2013 ThXou. All rights reserved.
//

#import "WithBarsViewController.h"
#import "LCMenuItem.h"

@import MapKit;


@interface WithBarsViewController ()

@end



@implementation WithBarsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *itemImage = [UIImage imageNamed:@"item.png"];
    ActionBlock actionBlock = ^(void)
    {
        [self performSegueWithIdentifier:@"ButtonPressed1" sender:nil];
    };
    
    
    LCMenuItem *item1 = [[LCMenuItem alloc] initWithImage:itemImage];
    item1.actionBlock = actionBlock;
    
    LCMenuItem *item2 = [[LCMenuItem alloc] initWithImage:itemImage withActionBlock:actionBlock];
    LCMenuItem *item3 = [[LCMenuItem alloc] initWithImage:itemImage withActionBlock:actionBlock];
    LCMenuItem *item4 = [[LCMenuItem alloc] initWithImage:itemImage withActionBlock:actionBlock];
    LCMenuItem *item5 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    LCMenuItem *item6 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    
    LCAnimatedMenu *menu = [[LCAnimatedMenu alloc] initWithItems:@[item1, item2, item3, item4, item5, item6]];
    menu.position = LCAnimatedMenuPositionTop;
    menu.showBelowTopBars = YES;
    menu.delegate = self;
    menu.containerView = self.view;
}



#pragma mark - LCAnimatedMenu Delegate

- (void)willDisplayAnimatedMenu:(LCAnimatedMenu *)animatedMenu
{
    NSLog(@"Menu will be displayed");
}


- (void)didDisplayAnimatedMenu:(LCAnimatedMenu *)animatedMenu
{
    NSLog(@"Menu is already displayed");
}


- (void)willHideAnimatedMenu:(LCAnimatedMenu *)animatedMenu
{
    NSLog(@"Menu is about to be hidden");
}



@end
