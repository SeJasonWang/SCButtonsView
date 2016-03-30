//
//  SCButtonsView.h
//  SCButtonView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCButtonsViewDelegate;

@interface SCButtonsView : UIView

@property (nonatomic, weak) id<SCButtonsViewDelegate> delegate;

- (void)reloadData;

- (nullable __kindof UIButton *)buttonAtIndex:(NSInteger)index;   // returns nil if index path is out of range

@end

@protocol SCButtonsViewDelegate <NSObject>

@required

- (NSInteger)numberOfButtonsInButtonsView:(SCButtonsView *)buttonsView;
- (nonnull UIButton *)buttonsView:(SCButtonsView *)buttonsView buttonAtIndex:(NSInteger)index;

@optional

- (NSInteger)columnsInButtonsView:(SCButtonsView *)buttonsView; // default is 3

@end

NS_ASSUME_NONNULL_END