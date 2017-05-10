
//  FogitPwdController.h
//  BeStronger
//
//  Created by Roy on 17/4/24.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FogitPwdController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *phoneTextFeild;

@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

- (IBAction)commitInfo:(id)sender;


@end
