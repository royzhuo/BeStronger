//
//  TicketSaleManager.h
//  BeStronger
//
//  Created by Roy on 16/11/26.
//  Copyright © 2016年 Roy. All rights reserved.
//

//模拟售票系统 用线程锁处理多线程访问统一资源的问题
#import <Foundation/Foundation.h>

#define Total 15

@interface TicketSaleManager : NSObject

@property NSInteger  tickets;//剩余票数
@property NSInteger saleCount;//售出票数

//模拟两个卖票的线程
@property(nonatomic,strong) NSThread *xmThread;
@property(nonatomic,strong) NSThread *qzThread;
@property(nonatomic,strong) NSCondition *threadCondition;

-(void) sale;
-(void) startThread;
@end
