//
//  OrderPlanController.h
//  BeStronger
//
//  Created by Roy on 17/5/7.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol orderPlanDelegate <NSObject>

-(void) orderPlan:(NSString *) plan;

@end

@interface OrderPlanController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *foodTextFeild;


@property (weak, nonatomic) IBOutlet UITextField *runTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *ortherTextFeild;

@property (weak, nonatomic) IBOutlet UIButton *orderBtn;

@property(strong,nonatomic) id<orderPlanDelegate> delegate;
- (IBAction)orderPlan:(id)sender;

@end
