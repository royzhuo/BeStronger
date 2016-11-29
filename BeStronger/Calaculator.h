//
//  Calaculator.h
//  BeStronger
//
//  Created by Roy on 16/11/29.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calaculator : NSObject
AS_SINGLETON(Calaculator)

@property(nonatomic,assign) int a;
@property(nonatomic,assign) int b;


-(int) add:(int )a andwith:(int )b;


@end
