//
//  RegisterBirthController.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistWeightController.h"

@protocol RegisterBirthDelleget <NSObject>


-(void)setSex:(int) sex setHeight:(float) height setWeight:(double) weight setBirth:(NSString *) birth setNickName:(NSString *)nickName setPhone:(NSString *)phone setPwd:(NSString *) pwd;

@end

@interface RegisterBirthController : UIViewController

@property(nonatomic,assign) int sex;
@property(nonatomic,assign) float height;
@property(nonatomic,assign) double weight;
@property(nonatomic,strong) NSString *nickName;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *pwd;
@property(nonatomic,strong) RegistWeightController *weightController;
@property(nonatomic,assign) id<RegisterBirthDelleget> delleget;


@property (weak, nonatomic) IBOutlet UILabel *birthLabel;



- (IBAction)back:(id)sender;

- (IBAction)next:(id)sender;


@end
