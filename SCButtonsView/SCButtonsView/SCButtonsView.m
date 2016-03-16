//
//  SCButtonsView.m
//  SCButtonsView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "SCButtonsView.h"
#import "SCButton.h"

@interface SCButtonAction()

@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) void(^handler)(SCButtonAction *action);

@end

@implementation SCButtonAction

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(SCButtonAction *))handler {
    SCButtonAction *action = [[SCButtonAction alloc] init];
    action.image = image;
    action.title = title;
    action.handler = handler;
    return action;
}

@end

@interface SCButtonsView()

@property (nonatomic, strong, readwrite) NSArray <SCButtonAction *> *actions;
@property (nonatomic, assign, readwrite) NSInteger columns;
@property (nonatomic, assign, readwrite) NSInteger rows;
@property (nonatomic, assign) CGFloat columnWidth;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation SCButtonsView

+ (instancetype)buttonViewWithColumns:(NSInteger)columns {
    return [self buttonViewWithColumns:columns frame:CGRectZero];
}

+ (instancetype)buttonViewWithColumns:(NSInteger)columns frame:(CGRect)frame {
    SCButtonsView *buttonView = [[SCButtonsView alloc] initWithFrame:frame];
    buttonView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.000];
    buttonView.columns = columns;
    return buttonView;
}

- (void)addAction:(SCButtonAction *)action {
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.actions];
    [arrM addObject:action];
    self.actions = [arrM copy];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.frame.size.height) {
        return;
    }
    
    NSInteger columns = self.columns;
    CGFloat w = self.columnWidth;
    CGFloat h = self.rowHeight;
    for (NSInteger i = self.buttons.count; i < self.actions.count; i++) {
        SCButton *button = [self createButtonWithAction:self.actions[i]];
        CGFloat x = (w + 0.5) * (i % columns);
        CGFloat y = (h + 0.5) * (i / columns) + 0.5;
        button.frame = CGRectMake(x, y, w, h);
        button.tag = 1000 + i;
        [self addSubview:button];
        [self.buttons addObject:button];
        [self createTipLabelInButton:button];
    }
}

#pragma mark - Private Method

- (SCButton *)createButtonWithAction:(SCButtonAction *)action {
    SCButton *button = [SCButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setBackgroundImage:[self backgroundImageWithColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [button setImage:action.image forState:UIControlStateNormal];
    [button setImage:action.image forState:UIControlStateHighlighted];
    [button setTitle:action.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:153/255.0 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UILabel *)createTipLabelInButton:(SCButton *)button {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    label.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    label.tag = 200;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 8.5;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(button.frame.size.width * 3 / 5 + 5, button.frame.size.height * 2 / 5 - 10);
    label.hidden = YES;
    [button addSubview:label];
    return label;
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
    SCButtonAction *action = self.actions[sender.tag - 1000];
    if (action.handler) {
        action.handler(action);
    }
}

#pragma mark - Getter

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (CGFloat)columnWidth {
    if (!_columnWidth) {
        _columnWidth = ([UIScreen mainScreen].bounds.size.width - (self.columns - 1) * 0.5) / self.columns;
    }
    return _columnWidth;
}

- (CGFloat)rowHeight {
    if (!_rowHeight) {
        _rowHeight = (self.frame.size.height - (self.rows + 1) * 0.5) / self.rows;
    }
    return _rowHeight;
}

- (NSInteger)rows {
    if (!_rows) {
        _rows = (self.actions.count + self.columns - 1) / self.columns;
    }
    return _rows;
}

- (UIButton *)buttonAtIndex:(NSUInteger)index {
    if (self.buttons.count > index) {
        return [self.buttons objectAtIndex:index];
    }
    return nil;
}

- (UILabel *)tipLabelAtIndex:(NSUInteger)index {
    if (self.buttons.count > index) {
        UIButton *button = [self.buttons objectAtIndex:index];
        return [button viewWithTag:200];
    }
    return nil;
}

@end
