//
//  LCAnimatedMenu.m
//  LCAnimatedMenu
//
//  Created by ThXou on 14/11/13.
//  Copyright (c) 2013 ThXou. All rights reserved.
//

#import "LCAnimatedMenu.h"
#import "LCMenuItem.h"


#define CONTAINER_VIEW_HEIGHT 64


@interface LCAnimatedMenu ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end


@implementation LCAnimatedMenu


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
        
        _items = [NSMutableArray array];
        _position = LCAnimatedMenuPositionBottom;
    }
    
    return self;
}



#pragma mark - Setter & Getter methods

- (void)setContainerView:(UIView *)containerView
{
    
    if (_containerView != containerView) {
        _containerView = containerView;
    }
    
    // set the frame for the container
    
    self.frame = [self createFrameForPosition:self.position andContainerView:_containerView];
    [_containerView addSubview:self];
    
    
    
}



#pragma mark - Private methods

- (void)animateEntranceForItem:(UIView *)item withDelay:(NSTimeInterval)delay
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];

    animation.values = @[@(64), @(-10), @(10), @(0)];;
    animation.keyTimes = @[@(0.0), @(0.40), @(0.70), @(0.8)];;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBackwards;
    animation.beginTime = CACurrentMediaTime() + delay;
    
    [item.layer addAnimation:animation forKey:@"Entrance"];
}


- (CGRect)createFrameForPosition:(LCAnimatedMenuPosition)position andContainerView:(UIView *)containerView
{
    CGRect frame = CGRectZero;
    
    switch (position)
    {
        case LCAnimatedMenuPositionBottom:
            frame = CGRectMake(0, containerView.bounds.size.height - CONTAINER_VIEW_HEIGHT, containerView.bounds.size.width, CONTAINER_VIEW_HEIGHT);
            break;
        case LCAnimatedMenuPositionTop:
            frame = CGRectMake(0, 0, containerView.bounds.size.width, CONTAINER_VIEW_HEIGHT);
            break;
        default:
            frame = CGRectMake(0, containerView.bounds.size.height - CONTAINER_VIEW_HEIGHT, containerView.bounds.size.width, CONTAINER_VIEW_HEIGHT);
            break;
    }
    
    return frame;
}



@end
