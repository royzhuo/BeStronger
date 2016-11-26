//
//  NSThreadController.m
//  BeStronger
//
//  Created by Roy on 16/11/25.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "NSThreadController.h"

#import "TicketSaleManager.h"
#import "TestSingger.h"

@interface NSThreadController ()

@end

@implementation NSThreadController


#pragma mark 视图
- (void)viewDidLoad {
    [super viewDidLoad];
//    TicketSaleManager *tickManager=[[TicketSaleManager alloc]init];
//    [tickManager startThread];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(100, 100, 200,60);
    button.backgroundColor=[UIColor blueColor];
    [button setTitle:@"nsthread线程按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickNSThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(100, 180, 200,60);
    button2.backgroundColor=[UIColor blueColor];
    [button2 setTitle:@"GCD线程按钮" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickGCD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame=CGRectMake(100, 250, 200,60);
    button3.backgroundColor=[UIColor blueColor];
    [button3 setTitle:@"单例" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(clickSingle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame=CGRectMake(100, 250, 200,60);
    button4.backgroundColor=[UIColor blueColor];
    [button4 setTitle:@"时间延迟" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(testTimeDelay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
}

#pragma mark 按钮点击事件
-(void) clickNSThread
{
//创建线程
    
    NSLog(@"主线程!!!!");
    //1.创建nstread的类
    NSThread *thread1=[[NSThread alloc]initWithTarget:self selector:@selector(threadRun) object:nil];
    thread1.name=@"thread1";
    [thread1 setThreadPriority:0.5];//设置线程优先级 越高越先进越高
    
    NSThread *thread2=[[NSThread alloc]initWithTarget:self selector:@selector(threadRun) object:nil];
    thread2.name=@"thread2";
    [thread2 setThreadPriority:0.6];
    
    [thread1 start];
    [thread2 start];
    //2.用类方法来创建
//    [NSThread detachNewThreadSelector:@selector(threadRun) toTarget:self withObject:nil];
    //3.performSelectorInBackground
    //[self performSelectorInBackground:@selector(threadRun) withObject:nil];

}

-(void )clickGCD
{
    //串行：是多线程要一个一个执行，时间是多个线程执行时间总和  并行：多个线程同时执行，时间是执行时间最长的线程
    //同步:当线程在执行过程中，ui不能操作     异步:在不阻塞ui操作过程中线程执行过程
    
//1.gcd简单使用
    NSLog(@"主线程");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{ //异步操作 并行
//        NSLog(@"start task ");
//        [NSThread sleepForTimeInterval:2];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"end task");
//        });
//    });
    
    //2.dispatch_get_global_queue(0, 0) 是并行操作的过程,可设置优先级
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 1");
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 2");
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 3");
//    });
    
    //3.手动创建,dispatch_queue_create 第一个参数唯一标识，第二个参数可设置串并行 默认是串行的(单一线程)，可改并行（多线程）
//    dispatch_queue_t queue=dispatch_queue_create("com.test.gcd", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 1");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 2");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 3");
//    });
    
    
    //4.dispatch_queue_group_t 使用
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_enter(group);
    [self sendRequest1:^{
        NSLog(@"task 1 done");
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self sendRequest2:^{
        NSLog(@"task 2 done");
        dispatch_group_leave(group);
    }];
    
    
//    dispatch_group_async(group, queue, ^{
////        NSLog(@"start task 1");
////        [NSThread sleepForTimeInterval:1];
////        NSLog(@"end task 1");
//        //调用异步方法
//        [self sendRequest1:^{
//            NSLog(@"task 1 done");
//        }];
//    });
//    dispatch_group_async(group, queue, ^{
////        NSLog(@"start task 2");
////        [NSThread sleepForTimeInterval:2];
////        NSLog(@"end task 2");
//        
//        //调用异步方法
//        
//        [self sendRequest2:^{
//            NSLog(@"task 2 done");
//        }];
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end task 3");
//    });
    
    //该方法对所有子线程任务回调，但是还在子线程中  ，但是如果是dispatch_group_async调用异步方法，效果则不能达到预期效果,可以使用  dispatch_group_enter(group);  dispatch_group_leave(group);成对使用
    dispatch_group_notify(group, queue, ^{
        NSLog(@"all task end");
        //切换成主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新ui线程");
        });
    });
    
    
    

}

-(void) sendRequest1:(void (^)())block
{
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSLog(@"start task 1");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"end task 1");
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
});


}

-(void) sendRequest2:(void (^)())block
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"end task 2");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
    
    
}

#pragma mark 单例
-(void)clickSingle
{
    TestSingger *single=[TestSingger instance];

    //NSLog(@"single:%@",single);
    
    
    //2.如果想让某一段代码只执行一次，则可以用dispatch_once()方法
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once click");
    });
}

#pragma mark dispatch_after 时间延迟
-(void)testTimeDelay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟2秒执行");
    });
}


#pragma mark 线程方法
-(void) threadRun
{
   
    NSLog(@"子线程,name:%@!!!!", [[NSThread currentThread]name]);
    NSLog(@"当前线程是否是主线程:%d", [[NSThread currentThread] isMainThread]);
    for (int i=1; i<=10; i++) {
        NSLog(@"%d",i);
        sleep(1);
        if (i==10) {
            //将线程切换回主线程（主线程通常进行ui更新操作）
           // [self performSelectorOnMainThread:nil withObject:nil waitUntilDone:YES];
        }
    };
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
