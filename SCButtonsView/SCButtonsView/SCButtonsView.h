//
//  SCButtonsView.h
//  SCButtonView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCButtonAction : NSObject

+ (instancetype)actionWithImage:(nullable UIImage *)image title:(nullable NSString *)title handler:(void (^ __nullable)(SCButtonAction *action))handler;

@property (nonatomic, strong, readonly, nullable) UIImage *image;
@property (nonatomic, copy, readonly, nullable) NSString *title;

@end

@interface SCButtonsView : UIView

+ (instancetype)buttonViewWithColumns:(NSInteger)columns frame:(CGRect)frame;
+ (instancetype)buttonViewWithColumns:(NSInteger)columns;

- (void)addAction:(SCButtonAction *)action;

@property (nonatomic, strong, readonly) NSArray <SCButtonAction *> *actions;
@property (nonatomic, assign, readonly) NSInteger columns;
@property (nonatomic, assign, readonly) NSInteger rows;

@end

NS_ASSUME_NONNULL_END