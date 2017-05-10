//
//  RegisterHeightController.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "RegisterHeightController.h"
#import "RegistWeightController.h"

@interface RegisterHeightController ()

@end

@implementation RegisterHeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.heightTextField setEnabled:YES];
    self.pwdFeild.secureTextEntry=YES;
    self.navigationItem.title=@"基本信息";
    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    
   
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)back:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
   // NSString *height=self.heightTextField.text;
    RegistWeightController *viewController= [StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"RW"];
//    viewController.heightController=self;
    self.delegate=viewController;
    
    if ([self.nickNameFeild.text isEqualToString:@""]) {
        [self showMessageTip:@"请填写昵称" detail:nil timeOut:1.5f];
        return;
    }
    if ([self.pwdFeild.text isEqualToString:@""]) {
        [self showMessageTip:@"请填写密码" detail:nil timeOut:1.5f];
        return;
    }
    if ([self.phoneNumberFeild.text isEqualToString:@""]) {
        [self showMessageTip:@"请填写手机号" detail:nil timeOut:1.5f];
        return;
    }
    //验证手机号码
    if ([self checkPhone:self.phoneNumberFeild.text]==false) {
        [self showMessageTip:@"请填写正确手机号" detail:nil timeOut:1.5f];
        return;
    }
    [self.delegate setSexValue:self.sexValue withNickName:self.nickNameFeild.text withPhone:self.phoneNumberFeild.text WithPwd:self.pwdFeild.text];
   // [self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark 验证电话号码
-(BOOL)checkPhone:(NSString *) phone
{

    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
//    NSString * CT = @"^1((33|53|8|7[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
//    BOOL res2 = [regextestcm evaluateWithObject:phone];
//    BOOL res3 = [regextestcu evaluateWithObject:phone];
//    BOOL res4 = [regextestct evaluateWithObject:phone];
    
    if (res1 ) {
        return YES;
    } else {
        return NO;
    }
}
@end
