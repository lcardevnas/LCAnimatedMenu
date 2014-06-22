
/*
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Luis Cardenas. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 
 This file is part of LCAnimatedMenu.
 Created by Luis Cardenas (ThXou)
 http://www.thxou.com
 
 */

#import "LCAnimatedMenu.h"
#import "LCMenuItem.h"


#define CONTAINER_VIEW_HEIGHT 74
#define ITEM_FRAME_WIDTH 64
#define DELAY_BETWEEN_ITEMS 0.3


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
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.showBelowTopBars = NO;
        
        _delay = 0.3;
        _animationDuration = 1.0;
        if (!_position) _position = LCAnimatedMenuPositionBottom;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didButtonPressed:)
                                                     name:LCMenuItemDidButtonPressed
                                                   object:nil];
    }
    
    return self;
}


- (instancetype)initWithItems:(NSArray *)items
{
    if (items) {
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
    
    
    // set the properties for the content and scroll views
    
    self.frame = [self createFrameInContainerView:_containerView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(self.items.count * ITEM_FRAME_WIDTH, CONTAINER_VIEW_HEIGHT);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.bounds.size.width, self.scrollView.bounds.origin.y);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    
    // we notify to the delegate that the menu is about to be displayed
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(willDisplayAnimatedMenu:)]) {
        [self.delegate willDisplayAnimatedMenu:self];
    }

    
    // animate the entrance of the items
    
    __block NSInteger count = 0;
    
    [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        
        if ([obj isMemberOfClass:[LCMenuItem class]])
        {
            LCMenuItem *item = (LCMenuItem *)obj;
            
            count += 1;
            CGFloat xCoordinate = self.scrollView.contentSize.width - ITEM_FRAME_WIDTH * count;
            item.frame = CGRectMake(xCoordinate, self.bounds.origin.y, 50, 50);
            item.center = CGPointMake(xCoordinate + ITEM_FRAME_WIDTH / 2, 40);
            
            [self.scrollView addSubview:item];
            [self animateEntranceForItem:item];
            
            self.delay += DELAY_BETWEEN_ITEMS;
        }
        else
        {
            *stop = YES;
            NSException *exception = [NSException exceptionWithName:@"Incompatible object"
                                                             reason:@"The item's array contains one or more objects that are not members of the LCMenuItem class"
                                                           userInfo:nil];
            [exception raise];
        }
        
    }];

    [_containerView addSubview:self];
    
    
    // we notify to the delegate that the menu is already displayed
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDisplayAnimatedMenu:)]) {
        [self.delegate didDisplayAnimatedMenu:self];
    }
    
}



#pragma mark - Animation methods

- (void)animateEntranceForItem:(UIView *)anItem
{
    
    NSArray *animationKeyTimes = @[ @(0.0), @(0.4), @(0.7), @(0.8) ];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.values = [self animationValues];
    animation.keyTimes = animationKeyTimes;
    
    
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.values = @[ @(0.0), @(0.5), @(1.0), @(1.0) ];
    opacity.keyTimes = animationKeyTimes;
    

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, opacity];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.duration = self.animationDuration;
    group.fillMode = kCAFillModeBackwards;
    group.removedOnCompletion = NO;
    group.beginTime = CACurrentMediaTime() + self.delay;
    
    [anItem.layer addAnimation:group forKey:@"Entrance"];

}


- (NSArray *)animationValues
{
    LCAnimatedMenuPosition position = self.position;
    NSArray *values = nil;
    
    switch (position)
    {
        case LCAnimatedMenuPositionBottom:
            values = @[ @(64), @(-10), @(10), @(0) ];
            break;
        case LCAnimatedMenuPositionTop:
            values = @[ @(-64), @(10), @(-10), @(0) ];
            break;
    }
    
    return values;
}



#pragma mark - Custom methods

- (void)didButtonPressed:(NSNotification *)notification
{
    
    // we notify to the delegate that the menu is about to be hidden
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(willHideAnimatedMenu:)]) {
        [self.delegate willHideAnimatedMenu:self];
    }
    
    
    // content view and items disappear and are removed from the container view
    // after fade out animation
    
    LCMenuItem *item = (LCMenuItem *)notification.object;
    
    if (item.actionBlock)
    {
        [UIView animateWithDuration:0.2f
                         animations:^{
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
    
}


- (CGRect)createFrameInContainerView:(UIView *)containerView
{
    
    CGRect frame = CGRectZero;
    LCAnimatedMenuPosition position = self.position;
    
    switch (position)
    {
        case LCAnimatedMenuPositionBottom:
        {
            frame = CGRectMake(0, containerView.bounds.size.height - CONTAINER_VIEW_HEIGHT, containerView.bounds.size.width, CONTAINER_VIEW_HEIGHT);
            break;
        }
        case LCAnimatedMenuPositionTop:
        {
            CGFloat offset = 0;
            if (self.showBelowTopBars) offset = 64.0f;
            frame = CGRectMake(0, offset, containerView.bounds.size.width, CONTAINER_VIEW_HEIGHT);
            break;
        }
    }
    
    return frame;
}



#pragma mark - Memory management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
