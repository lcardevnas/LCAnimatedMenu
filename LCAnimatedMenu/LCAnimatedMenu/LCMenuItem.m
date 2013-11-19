//
//  LCMenuItem.m
//  LCAnimatedMenu
//
//  Created by ThXou on 14/11/13.
//  Copyright (c) 2013 ThXou. All rights reserved.
//

#import "LCMenuItem.h"


@interface LCMenuItem ()

@property (nonatomic, readwrite) NSInteger index;
@property (strong, nonatomic) UIImage *image;

@end


@implementation LCMenuItem


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    // set de the stroke and fill color of the button
    [[UIColor grayColor] setStroke];
    [[UIColor redColor] setFill];
    
    // making the rect of the button
    CGRect rectCircle = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rectCircle];
    
    // fill the path area
    [circlePath setLineWidth:4.0];
    [circlePath stroke];
    [circlePath fill];
    
}


@end
