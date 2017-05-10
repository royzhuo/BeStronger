//
//  UpdatePwdController.m
//  BeStronger
//
//  Created by Roy on 17/4/24.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "UpdatePwdController.h"

@interface UpdatePwdController ()

@end

@implementation UpdatePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"密码修改";
    self.updatePwdBtn.layer.cornerRadius=8.0f;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    self.pwdTextFeild.secureTextEntry=YES;
    self.aginTextField.secureTextEntry=YES;
    
    [self.view addGestureRecognizer:singleTap];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)updatePwd:(id)sender {
    
    int userid=[User sharedInstance].userId;
    NSNumber *userId=[[NSNumber alloc]initWithInt:userid];
    
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.pwdTextFeild.text,@"pwd",userId,@"userId", nil];

    if ([self checkPwd]) {
        [[HttpTool sharedInstance] Post:@"/api/user/updatePwd" params:params success:^(id responseObj) {
            if (responseObj) {
                if ([[responseObj valueForKey:@"code"] isEqualToString:@"200"]) {
                    [self showMessageTip:[responseObj valueForKey:@"message"]detail:nil timeOut:0.3f];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
                [self showMessageTip:[responseObj valueForKey:@"message"]detail:nil timeOut:0.3f];
            }
        } failure:^(NSError *error) {
            if (error) {
                [self showMessageTip:@"程序异常" detail:nil timeOut:0.3f];
            }
        }];
    }
   
}


-(BOOL) checkPwd
{
    if ([self.pwdTextFeild.text isEqualToString:@""]||[self.aginTextField.text isEqualToString:@""]) {
        [self showMessageTip:@"请输入密码" detail:nil timeOut:0.3f];
        return false;
    }
    if (![self.pwdTextFeild.text isEqualToString:self.aginTextField.text]) {
        [self showMessageTip:@"密码不一致" detail:nil timeOut:0.3];
        return false;
    }
    if ([User sharedInstance].userId==NULL||[User sharedInstance].userId==0) {
        [self showMessageTip:@"没有用户数据" detail:nil timeOut:0.3];
        return false;
    }
    return true;


}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
}
@end
