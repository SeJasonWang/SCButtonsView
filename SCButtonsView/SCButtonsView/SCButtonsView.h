//
//  SCButtonsView.h
//  SCButtonsView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCButtonAction : NSObject

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(SCButtonAction *action))handler;

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) NSString *title;

@end

@interface SCButtonsView : UIView

+ (instancetype)buttonViewWithColumns:(NSInteger)columns frame:(CGRect)frame;
+ (instancetype)buttonViewWithColumns:(NSInteger)columns;

- (void)addAction:(SCButtonAction *)action;

@property (nonatomic, strong, readonly) NSArray <SCButtonAction *> *actions;
@property (nonatomic, assign, readonly) NSInteger columns;
@property (nonatomic, assign, readonly) NSInteger rows;

- (UIButton *)buttonAtIndex:(NSUInteger)index;
- (UILabel *)tipLabelAtIndex:(NSUInteger)index;

@end
