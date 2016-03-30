//
//  ViewController.m
//  SCButtonsView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "ViewController.h"
#import "SCNoDelayButtonScrollView.h"
#import "SCButtonsView.h"
#import "SCButton.h"

@interface ViewController()<SCButtonsViewDelegate>

@end

@implementation ViewController
{
    NSInteger _number;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    SCNoDelayButtonScrollView *scrollView = [[SCNoDelayButtonScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(size.width, size.height * 1.5);
    [self.view addSubview:scrollView];
    
    SCButtonsView *buttonsView = [[SCButtonsView alloc] initWithFrame:CGRectMake(50, 0.5, size.width - 100, size.height * 1.5 - 1.0)];
    buttonsView.delegate = self;
    [scrollView addSubview:buttonsView];
    
    _number = 18;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _number = 24;
        [buttonsView reloadData];
    });
}

- (NSInteger)numberOfButtonsInButtonsView:(SCButtonsView *)buttonsView {
    return _number;
}

- (UIButton *)buttonsView:(SCButtonsView *)buttonsView buttonAtIndex:(NSInteger)index {
    SCButton *button = [SCButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"首页" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    return button;
}

@end
