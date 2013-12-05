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
#define ITEM_FRAME_WIDTH 64
#define DELAY_BETWEEN_ITEMS 0.2


@interface LCAnimatedMenu ()

@property (nonatomic) NSTimeInterval delay;
@property (strong, nonatomic) UIScrollView *scrollView;

@end



@implementation LCAnimatedMenu


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor greenColor];
        if (!_position) _position = LCAnimatedMenuPositionBottom;
    }
    
    return self;
}


- (instancetype)initWithItems:(NSArray *)items
{
    if (items)
    {
        _items = [items mutableCopy];
    }
    
    return [self initWithFrame:CGRectZero];
}



#pragma mark - Setter & Getter methods

- (void)setContainerView:(UIView *)containerView
{
    
    if (_containerView != containerView) {
        _containerView = containerView;
    }
    
    
    // set the frame for the container
    
    self.frame = [self createFrameForPosition:self.position andContainerView:_containerView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(self.items.count * ITEM_FRAME_WIDTH, self.bounds.size.height);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, self.scrollView.bounds.origin.y);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    

    // animate the entrance of the items
    
    self.delay = 0.3;
    
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        LCMenuItem *item = (LCMenuItem *)obj;
        
        idx += 1;
        CGFloat xCoordinate = self.scrollView.contentSize.width - ITEM_FRAME_WIDTH * idx;
        item.frame = CGRectMake(xCoordinate, self.bounds.origin.y, 50, 50);
        item.center = CGPointMake(xCoordinate + ITEM_FRAME_WIDTH / 2, CONTAINER_VIEW_HEIGHT / 2);
        item.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:item];
        [self animateEntranceForItem:item withDelay:self.delay];
        
        self.delay += DELAY_BETWEEN_ITEMS;
    }];

    [_containerView addSubview:self];
    
}



#pragma mark - Private methods

- (void)animateEntranceForItem:(UIView *)item withDelay:(NSTimeInterval)delay
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];

    animation.values = @[ @(64), @(-10), @(10), @(0) ];
    animation.keyTimes = @[ @(0.0), @(0.40), @(0.70), @(0.8) ];
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
