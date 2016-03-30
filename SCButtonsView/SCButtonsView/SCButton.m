//
//  SCButton.m
//  SCButtonsView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCButton.h"

@implementation UIView (SCTitleButton)

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

@end

@implementation SCButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeSubviews];
    }
    return self;
}

- (void)initializeSubviews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundImage:[self backgroundImageWithColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:153/255.0 alpha:1] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image && self.titleLabel.text) {
        self.imageView.centerX = self.frame.size.width / 2;
        self.imageView.centerY = self.frame.size.height / 2 - 12;
        self.titleLabel.centerX = self.frame.size.width / 2;
        self.titleLabel.centerY = self.frame.size.height / 2 + 15;
    }
}

- (UIImage *)backgroundImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
