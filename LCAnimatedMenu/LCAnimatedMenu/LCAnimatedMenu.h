//
//  LCAnimatedMenu.h
//  LCAnimatedMenu
//
//  Created by ThXou on 14/11/13.
//  Copyright (c) 2013 ThXou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LCAnimatedMenuPosition) {
    LCAnimatedMenuPositionBottom,
    LCAnimatedMenuPositionTop
};


@class LCMenuItem;


@interface LCAnimatedMenu : UIView

@property (strong, nonatomic) NSMutableArray *items;
@property (nonatomic) LCAnimatedMenuPosition position;

@property (strong, nonatomic) UIView *containerView;


@end
