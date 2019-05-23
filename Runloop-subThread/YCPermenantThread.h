//
//  YCPermenantThread.h
//  Runloop-subThread
//
//  Created by Yaanco on 2019/5/7.
//  Copyright © 2019 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

//void (^ _Nullable ExecuteTask)(void);


NS_ASSUME_NONNULL_BEGIN

@interface YCPermenantThread : NSObject

/**
 开启一个子线程
 */
- (void)run;

/**
 在子线程执行任务

 @param task 任务
 */
- (void)executeThreadTask:(void (^)(void))task;

/**
 停止子线程
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
