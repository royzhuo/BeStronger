//
//  OrderPlanController.m
//  BeStronger
//
//  Created by Roy on 17/5/7.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "OrderPlanController.h"

@interface OrderPlanController (){

    NSString *foodPlan;
    NSString *runningPlan;
    NSString *ortherPlan;

}

@end

@implementation OrderPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"定制";
    self.tabBarController.tabBar.hidden=YES;
    
    _orderBtn.layer.cornerRadius=8.0f;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}



- (IBAction)orderPlan:(id)sender {
    
    
    
    NSMutableString *planString=[[NSMutableString alloc]init];
    if ([self checkParam]) {
        [planString appendString:@"饮食:"];
        [planString appendString:foodPlan];
        [planString appendString:@"\n 跑步:"];
        [planString appendString:runningPlan];
        if (![_ortherTextFeild.text isEqualToString:@""]) {
            ortherPlan=_ortherTextFeild.text;
            [planString appendString:@"\n 其它:"];
            [planString appendString:ortherPlan];
        }
        NSNumber *userId=[NSNumber numberWithInt:[User sharedInstance].userId];
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:planString,@"plan",
                              userId ,@"id",
                              nil];
        [[HttpTool sharedInstance] Post:@"/api/user/orderPlan" params:params success:^(id responseObj) {
            if ([[responseObj valueForKey:@"code"] isEqualToString:@"200"]) {
                [self showSuccessTip:[NSString stringWithFormat:@"%@",[responseObj valueForKey:@"message"]] timeOut:0.3f];
                
                [User sharedInstance].healthAdvice=[responseObj valueForKey:@"result"];
                [self.delegate orderPlan:[User sharedInstance].healthAdvice];
                [self.navigationController popViewControllerAnimated:YES];
            }
            if ([[responseObj valueForKey:@"code"] isEqualToString:@"200_500"]) {
                [self showMessageTip:@"定制失败" detail:nil timeOut:0.3f];
                
            }
        } failure:^(NSError *error) {
            if (error) {
                [self showMessageTip:@"网络异常" detail:nil timeOut:0.3f];
            }
        }];
    }

    
    
}


-(BOOL) checkParam
{
    
    if ([self.foodTextFeild.text isEqualToString:@""]|| [self.runTextFeild.text isEqualToString:@""]) {
        [self showMessageTip:@"饮食计划和跑步计划不能为空" detail:nil timeOut:0.3f];
        return false;
    }
    foodPlan=self.foodTextFeild.text;
    runningPlan=self.runTextFeild.text;
    return true;

}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    [self.view endEditing:YES];
}
@end
