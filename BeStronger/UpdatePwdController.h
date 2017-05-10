//
//  UpdatePwdController.h
//  BeStronger
//
//  Created by Roy on 17/4/24.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePwdController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *updatePwdBtn;


@property (weak, nonatomic) IBOutlet UITextField *pwdTextFeild;

@property (weak, nonatomic) IBOutlet UITextField *aginTextField;


- (IBAction)updatePwd:(id)sender;



@end
