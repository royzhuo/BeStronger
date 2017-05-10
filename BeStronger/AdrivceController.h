//
//  AdrivceController.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterBirthController.h"

@interface AdrivceController : UIViewController

@property(nonatomic,strong) RegisterBirthController *birthController;
@property(nonatomic,assign) id<RegisterBirthDelleget> delegate;
@property(assign,nonatomic) float height;
@property(assign,nonatomic) double weight;
@property(strong,nonatomic) NSString *birthday;
@property(nonatomic,assign) double bmi;
@property(nonatomic,strong) NSString *advice;

@property(nonatomic,strong) NSString *nickName;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *pwd;

- (IBAction)back:(id)sender;

- (IBAction)ok:(id)sender;

@end
