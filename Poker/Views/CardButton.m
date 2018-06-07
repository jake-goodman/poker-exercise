//
//  CardView.m
//  Poker
//
//  Created by Jake Goodman on 6/5/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import "CardButton.h"

@interface CardButton ()
- (void) setupView;
@end

@implementation CardButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.layer setCornerRadius:6];
    [self setBackgroundColor:UIColor.whiteColor];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self setClipsToBounds:false];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        //Set Shadow
        [self.layer setShadowColor:UIColor.yellowColor.CGColor];
        [self.layer setShadowOpacity:1.0];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        [self.layer setShadowRadius:4.0];
        
        //Set Border
        [self.layer setBorderColor:UIColor.yellowColor.CGColor];
        [self.layer setBorderWidth:2.0];

    } else {
        [self.layer setShadowColor:UIColor.clearColor.CGColor];
        [self.layer setBorderWidth:0];
    }
}

@end
