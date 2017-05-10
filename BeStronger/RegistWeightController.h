//
//  RegistWeightController.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterHeightController.h"

@protocol WeightControllerDelleget <NSObject>

-(void)setWeight:(double) weight setSex:(int) sex setHeight:(float) height;

-(void)setWeight:(double) weight setSex:(int) sex setHeight:(float) height setNickName:(NSString *)nickName setPhone:(NSString *) phone setPwd:(NSString *) pwd;
@end

@interface RegistWeightController : UIViewController

@property(nonatomic,assign) int sex;
@property(nonatomic,strong) NSString *nickName;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *pwd;
@property(nonatomic,strong) id<WeightControllerDelleget> delleget;
@property(nonatomic,strong) RegisterHeightController *heightController;

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

@property (weak, nonatomic) IBOutlet UITextField *heightFeild;


- (IBAction)back:(id)sender;

- (IBAction)next:(id)sender;
@end
