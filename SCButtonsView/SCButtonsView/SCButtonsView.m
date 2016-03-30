//
//  SCButtonsView.m
//  SCButtonView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCButtonsView.h"
#import "SCButton.h"

@implementation SCButtonsView
{
    NSMutableArray *_buttons;
    BOOL _needsReload;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeSubViews];
    }
    return self;
}

- (void)initializeSubViews {
    _needsReload = YES;
    self.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.000];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_needsReload) {
        _needsReload = NO;
        [self reloadData];
    }
}

- (void)reloadData {
    if (!self.frame.size.height) {
        return;
    }
    
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttons removeAllObjects];
    
    CGFloat w = self.columnWidth;
    CGFloat h = self.rowHeight;
    NSInteger numberOfButtons = self.numberOfButtons;
    NSInteger columns = self.columns;
    for (NSInteger i = 0; i < numberOfButtons; i++) {
        SCButton *button = [self createButtonAtIndex:i];
        CGFloat x = (w + 0.5) * (i % columns);
        CGFloat y = (h + 0.5) * (i / columns) + 0.5;
        button.frame = CGRectMake(x, y, w, h);
        button.tag = i;
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    if (index >= 0 && index < self.buttons.count) {
        return self.buttons[index];
    } else {
        return nil;
    }
}

#pragma mark - Private Method

- (SCButton *)createButtonAtIndex:(NSInteger)index {
    
    NSString *text;
    UIImage *image;
    if ([self.delegate respondsToSelector:@selector(buttonsView:textAtIndex:)]) {
        text = [self.delegate buttonsView:self textAtIndex:index];
    }
    if ([self.delegate respondsToSelector:@selector(buttonsView:imageAtIndex:)]) {
        image = [self.delegate buttonsView:self imageAtIndex:index];
    }
    
    SCButton *button = [SCButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setBackgroundImage:[self backgroundImageWithColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:153/255.0 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
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

- (void)buttonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buttonsView:didPressedAtIndex:)]) {
        [self.delegate buttonsView:self didPressedAtIndex:sender.tag];
    }
}

#pragma mark - Getter

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSInteger)numberOfButtons {
    return [self.delegate numberOfButtonsInButtonsView:self];
}

- (NSInteger)columns {
    if ([self.delegate respondsToSelector:@selector(columnsInButtonsView:)]) {
        return [self.delegate columnsInButtonsView:self] ? : 3;
    } else {
        return 3;
    }
}

- (CGFloat)columnWidth {
    return (self.frame.size.width - (self.columns - 1) * 0.5) / self.columns;
}

- (CGFloat)rowHeight {
    return (self.frame.size.height - (self.rows + 1) * 0.5) / self.rows;
}

- (NSInteger)rows {
    return (self.numberOfButtons + self.columns - 1) / self.columns;
}

@end
