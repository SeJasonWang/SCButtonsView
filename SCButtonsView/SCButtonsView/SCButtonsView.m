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
    NSInteger _numberOfButtons;
    NSInteger _columns;
    NSInteger _rows;
    CGFloat   _columnWidth;
    CGFloat   _rowHeight;
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

#pragma mark - Public Method

- (void)reloadData {
    if (!self.frame.size.height || !self.frame.size.width) {
        return;
    }
    
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _buttons = nil;
    _numberOfButtons = 0;
    _columns = 0;
    _rows = 0;
    _columnWidth = 0;
    _rowHeight = 0;
    
    NSInteger numberOfButtons = self.numberOfButtons;
    NSInteger columns = self.columns;
    CGFloat w = self.columnWidth;
    CGFloat h = self.rowHeight;
    for (NSInteger i = 0; i < numberOfButtons; i++) {
        UIButton *button = [self createButtonAtIndex:i];
        CGFloat x = (w + 0.5) * (i % columns) + 0.5;
        CGFloat y = (h + 0.5) * (i / columns) + 0.5;
        button.frame = CGRectMake(x, y, w, h);
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

- (UIButton *)createButtonAtIndex:(NSInteger)index {
    UIButton *button = nil;
    if ([self.delegate respondsToSelector:@selector(buttonsView:buttonAtIndex:)]) {
        button = [self.delegate buttonsView:self buttonAtIndex:index];
        if (button) {
            return button;
        }
    }
    NSAssert(button != nil, @"SCButtonsView <%@> failed to obtain a button from its delegate (%@)", self, self.delegate);
    return button;
}

#pragma mark - Getter

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSInteger)numberOfButtons {
    if (!_numberOfButtons) {
        _numberOfButtons = [self.delegate numberOfButtonsInButtonsView:self];
    }
    return _numberOfButtons;
}

- (NSInteger)columns {
    if (!_columns) {
        if ([self.delegate respondsToSelector:@selector(columnsInButtonsView:)]) {
            _columns = [self.delegate columnsInButtonsView:self] ? : 3;
        } else {
            _columns = 3;
        }
    }
    return _columns;
}

- (NSInteger)rows {
    if (!_rows) {
        _rows = (self.numberOfButtons + self.columns - 1) / self.columns;
    }
    return _rows;
}

- (CGFloat)columnWidth {
    if (!_columnWidth) {
        _columnWidth = (self.frame.size.width - (self.columns + 1) * 0.5) / self.columns;
    }
    return _columnWidth;
}

- (CGFloat)rowHeight {
    if (!_rowHeight) {
        _rowHeight = (self.frame.size.height - (self.rows + 1) * 0.5) / self.rows;
    }
    return _rowHeight;
}

@end
