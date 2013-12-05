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
@property (copy, nonatomic) NSString *text;

@end


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
    }
    
    return self;
}


- (id)initWithText:(NSString *)text
{
    if (text)
    {
        _text = text;
    }
    
    return [self initWithFrame:CGRectZero];
}


- (void)drawRect:(CGRect)rect
{
    
    // making the rect of the button
    
    CGRect rectCircle = CGRectInset(self.bounds, self.bounds.size.width * 0.04f, self.bounds.size.height * 0.04f);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rectCircle];
    
    
    // set the text
    
    if (self.text)
    {
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeMake(-1, -1);
        
        UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment:NSTextAlignmentCenter];
        
        NSDictionary *attr = @{
                               NSParagraphStyleAttributeName : style,
                               NSFontAttributeName : font,
                               NSShadowAttributeName : shadow,
                               NSForegroundColorAttributeName : [UIColor yellowColor]
                               };
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.text attributes:attr];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.attributedText = attrString;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        /*
        NSLog(@"CENTER: %@", NSStringFromCGPoint(self.center));
        NSLog(@"FRAME: %@", NSStringFromCGRect(self.frame));
        NSLog(@"BOUNDS: %@", NSStringFromCGRect(self.bounds));
        [self.text drawAtPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                withAttributes:attr];
//        [self.text drawInRect:rectCircle
//               withAttributes:attr];*/
    }
    
    
    // set de the stroke and fill color of the button
    
    [[UIColor grayColor] setStroke];
    [[UIColor redColor] setFill];
    
    
    // fill the path area
    
    [circlePath setLineWidth:4.0];
    [circlePath stroke];
    [circlePath fill];
    
}


@end
