//
//  TicketSaleManager.m
//  BeStronger
//
//  Created by Roy on 16/11/26.
//  Copyright © 2016年 Roy. All rights reserved.
//


#import "TicketSaleManager.h"

@implementation TicketSaleManager

-(instancetype)init
{
    if (self=[super init]) {
        //创建线程
        self.xmThread=[[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        [self.xmThread setName:@"xia men"];
        self.qzThread=[[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        [self.qzThread setName:@"quan zhou"];
        self.threadCondition=[[NSCondition alloc]init];
        self.tickets=Total;
    }
    return self;
}

-(void)sale
{
    while (self.tickets>0) {
       // @synchronized (self) {//1.@synchronize同步锁
        //2.nscodition
        [self.threadCondition lock];
            if (self.tickets>0) {
                [NSThread sleepForTimeInterval:0.5];//睡眠一秒
                self.tickets--;
                self.saleCount=Total-self.tickets;
                
                NSLog(@"当前售票点:%@,总已售出:%ld张,剩余:%ld张", [[NSThread currentThread]name],(long)self.saleCount,(long)self.tickets);
                
            }
        [self.threadCondition unlock];
        //}
            }



}

-(void)startThread
{
    [self.xmThread start];
    [self.qzThread start];
}
@end
