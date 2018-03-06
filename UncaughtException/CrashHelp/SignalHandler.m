//
//  SignalHandler.m
//  UncaughtExceptionDemo
//
//  Created by Phoenix on 2018/3/6.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "SignalHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>
#import "UncaughtExceptionHandler.h"


@interface SignalHandler()<UIAlertViewDelegate>

@end


@implementation SignalHandler

+ (void)saveCrash:(NSString *)exceptionInfo {
    NSString *_libPath  = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"SigCrash"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:_libPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_libPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSString *savePath = [_libPath stringByAppendingFormat:@"/error%@.log",timeString];
    
    BOOL sucess = [exceptionInfo writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"YES sucess:%d",sucess);
}


@end


void SignalExceptionHandler(int signal) {
    NSMutableString *crashInfo = [[NSMutableString alloc] init];
    [crashInfo appendString:@"Stack:\n"];
    void *callstack[128];
    int i, frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    for (i = 0; i < frames; ++i) {
        [crashInfo appendFormat:@"%s\n", strs[i]];
    }
    [SignalHandler saveCrash:crashInfo];
}

void InstallSignalHandler(void) {
    signal(SIGHUP, SignalExceptionHandler);
    signal(SIGINT, SignalExceptionHandler);
    signal(SIGQUIT, SignalExceptionHandler);
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

