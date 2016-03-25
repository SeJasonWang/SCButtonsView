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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize size = [UIScreen mainScreen].bounds.size;

    SCNoDelayButtonScrollView *scrollView = [[SCNoDelayButtonScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(size.width, size.height * 2);
    [self.view addSubview:scrollView];
    
    SCButtonsView *buttonsView = [SCButtonsView buttonViewWithColumns:3];
    buttonsView.frame = CGRectMake(0, 0.5, size.width, size.height * 2 - 1.0);
    [scrollView addSubview:buttonsView];
    
    for (NSInteger i = 0; i < 24; i++) {
        SCButtonAction *action = [SCButtonAction actionWithImage:[UIImage imageNamed:@"home_add"] title:@"首页" handler:nil];
        [buttonsView addAction:action];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
