
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

#import "LCMenuItem.h"


@interface LCMenuItem ()

@property (nonatomic, readwrite) NSInteger index;

@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *text;

@end


NSString *LCMenuItemDidButtonPressed = @"kLCMenuItemDidButtonPressed";


@implementation LCMenuItem


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 24.0;
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        if (!_innerColor) _innerColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        if (!_borderColor) _borderColor = [UIColor grayColor];
        if (!_lineWidth) _lineWidth = 1.0;
    }
    
    return self;
}


- (id)initWithImage:(UIImage *)image
{
    if (image)
    {
        _image = image;
    }
    
    return [self initWithFrame:CGRectZero];
}


- (id)initWithImage:(UIImage *)image withActionBlock:(ActionBlock)actionBlock
{
    if (image)
    {
        _image = image;
        _actionBlock = actionBlock;
    }
    
    return [self initWithFrame:CGRectZero];
}


- (void)drawRect:(CGRect)rect
{
    
    // making the rect of the button
    
    CGRect rectCircle = CGRectInset(self.bounds, self.bounds.size.width * 0.04f, self.bounds.size.height * 0.04f);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rectCircle];
    
    [self.borderColor setStroke];
    [self.innerColor setFill];
    
    [circlePath fill];
    [circlePath setLineWidth:self.lineWidth];
    [circlePath stroke];
    
    
    // set the image
    
    UIButton *itemButton = [[UIButton alloc] initWithFrame:self.bounds];
    [itemButton addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    if (self.image)
    {
        [itemButton setImage:self.image forState:UIControlStateNormal];
        [itemButton setContentMode:UIViewContentModeCenter];
    }
    
    [self addSubview:itemButton];
    
}



#pragma mark - Private methods

- (void)buttonAction:(UIButton *)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:LCMenuItemDidButtonPressed
                                      object:self];
}



@end
