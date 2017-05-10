//
//  MyPlanController.m
//  BeStronger
//
//  Created by Roy on 17/5/1.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyPlanController.h"
#import "OrderPlanController.h"

@interface MyPlanController ()<orderPlanDelegate>{

    UITextView *textView;
}

@end

@implementation MyPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title=@"我的计划";
    
    UIBarButtonItem *orderBtn=[[UIBarButtonItem alloc]initWithTitle:@"订制" style:UIBarButtonItemStylePlain target:self action:@selector(updateAdvice)];
    orderBtn.tintColor=[UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem=orderBtn;
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200)];
    [self.view addSubview:textView];
    NSString *advice=[User sharedInstance].healthAdvice;
    [textView setText:advice];
    [textView setEditable:NO];
   }






-(void)updateAdvice
{
    OrderPlanController *orderPlan=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"orderPlan"];
    orderPlan.delegate=self;
    [self.navigationController pushViewController:orderPlan animated:YES];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

-(void)orderPlan:(NSString *)plan
{
        textView.text=[User sharedInstance].healthAdvice;
}
@end
