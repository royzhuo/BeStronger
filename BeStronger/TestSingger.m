//
//  TestSingger.m
//  BeStronger
//
//  Created by Roy on 16/11/26.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "TestSingger.h"

@implementation TestSingger

+(instancetype)instance
{
    static dispatch_once_t onetoken;
    static TestSingger *single=nil;
    dispatch_once(&onetoken, ^{
        NSLog(@"单例方法");
        single=[[TestSingger alloc]init];
    });

    return single;
}

@end
