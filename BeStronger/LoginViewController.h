//
//  LoginViewController.h
//  BeStronger
//
//  Created by Roy on 17/3/15.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNav.h"

@interface LoginViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *userNameTextView;


@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;


@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIButton *fogitBtn;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

- (IBAction)registerUser:(id)sender;

- (IBAction)retrievePassword:(id)sender;


- (IBAction)login:(id)sender;



@end
