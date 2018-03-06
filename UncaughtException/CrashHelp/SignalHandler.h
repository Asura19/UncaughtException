//
//  SignalHandler.h
//  UncaughtExceptionDemo
//
//  Created by Phoenix on 2018/3/6.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignalHandler : NSObject

+ (void)saveCrash:(NSString *)exceptionInfo;

@end

void InstallSignalHandler(void);
