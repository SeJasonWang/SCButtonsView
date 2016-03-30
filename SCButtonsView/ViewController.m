//
//  ViewController.m
//  SCButtonsView
//
//  Created by sichenwang on 16/3/16.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "ViewController.h"
#import "SCButtonsView.h"
#import "SCNoDelayButtonScrollView.h"

@interface ViewController()<SCButtonsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize size = [UIScreen mainScreen].bounds.size;

    SCNoDelayButtonScrollView *scrollView = [[SCNoDelayButtonScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(size.width, size.height * 1.5);
    [self.view addSubview:scrollView];
    
    SCButtonsView *buttonsView = [[SCButtonsView alloc] initWithFrame:CGRectMake(0, 0.5, size.width, size.height * 1.5 - 1.0)];
    buttonsView.delegate = self;
    [scrollView addSubview:buttonsView];
}

- (NSInteger)numberOfButtonsInButtonsView:(SCButtonsView *)buttonsView {
    return 18;
}

- (NSString *)buttonsView:(SCButtonsView *)buttonsView textAtIndex:(NSInteger)index {
    return @"首页";
}

- (UIImage *)buttonsView:(SCButtonsView *)buttonsView imageAtIndex:(NSInteger)index {
    return [UIImage imageNamed:@"home_add"];
}

@end
