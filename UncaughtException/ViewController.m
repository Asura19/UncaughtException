//
//  ViewController.m
//  UncaughtException
//
//  Created by Phoenix on 2018/3/6.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "ViewController.h"

typedef struct Test {
    int a;
    int b;
} Test;

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)ocException:(UIButton *)sender {
    NSArray *arr = @[@1, @2, @3];
    NSNumber *n = arr[4];
}

- (IBAction)signalCrash:(UIButton *)sender {
    Test *t = {1,2};
    free(t);
    t->a = 5;
}

@end
