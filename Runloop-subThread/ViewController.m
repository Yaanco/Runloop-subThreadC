//
//  ViewController.m
//  Runloop-subThread
//
//  Created by Yaanco on 2019/5/7.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "ViewController.h"
#import "YCPermenantThread.h"

@interface ViewController ()
@property (nonatomic, strong) YCPermenantThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[YCPermenantThread alloc] init];
    [self.thread run];
}

// 停止子线程
- (IBAction)stop {
    [self.thread stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread executeThreadTask:^{
        NSLog(@"=====executeTask====");
    }];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
