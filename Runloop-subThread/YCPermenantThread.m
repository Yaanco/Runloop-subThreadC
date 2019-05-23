//
//  YCPermenantThread.m
//  Runloop-subThread
//
//  Created by Yaanco on 2019/5/7.
//  Copyright © 2019 Andy. All rights reserved.
//

#import "YCPermenantThread.h"

@interface YCThread : NSThread
@end
@implementation YCThread

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end


@interface YCPermenantThread ()
@property (nonatomic, strong) YCThread *thread;
@end
@implementation YCPermenantThread

#pragma mark ---public methods---
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.thread = [[YCThread alloc] initWithBlock:^{
            NSLog(@"begin ---");
            // 创建上下文（要初始化一下结构体）
            CFRunLoopSourceContext context = {0};
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            // 第3个参数：returnAfterSourceHandled，设置为true，代表执行完source后就会退出当前loop
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
            NSLog(@"end ---");
        }];
    }
    return self;
}

- (void)run {
    [self.thread start];
}

- (void)executeThreadTask:(void (^)(void))task {
    if(!self.thread) return;
    [self performSelector:@selector(__executeThreadTask:) onThread:self.thread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if(!self.thread) return;
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self stop];
}

#pragma mark ---private methods---
- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeThreadTask:(void (^)(void))task {
    task();
}

@end
