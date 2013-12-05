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
    
    
    LCMenuItem *item1 = [[LCMenuItem alloc] initWithText:@"Bubi"];
    LCMenuItem *item2 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    LCMenuItem *item3 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    LCMenuItem *item4 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    LCMenuItem *item5 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    LCMenuItem *item6 = [[LCMenuItem alloc] initWithFrame:CGRectZero];
    
    LCAnimatedMenu *menu = [[LCAnimatedMenu alloc] initWithItems:@[item1, item2, item3, item4, item5, item6]];
    menu.position = LCAnimatedMenuPositionBottom;
    menu.containerView = self.view;

}



@end
