//
//  NSObject+Tips.h
//  智能社区
//
//  Created by Roy on 16/3/23.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tips)

- (void)showSuccessTip:(NSString *)string timeOut:(NSTimeInterval)interval;

- (void)showLoaddingTip:(NSString *)string timeOut:(NSTimeInterval)interval;

- (void)showFailureTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval;

- (void)showMessageTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval;

-(void) dissmissTips;

@end
