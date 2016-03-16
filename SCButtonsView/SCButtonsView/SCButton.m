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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image && self.titleLabel.text) {
        self.imageView.centerX = self.frame.size.width / 2;
        self.imageView.centerY = self.frame.size.height / 2 - 12;
        self.titleLabel.centerX = self.frame.size.width / 2;
        self.titleLabel.centerY = self.frame.size.height / 2 + 15;
    }
}

@end
