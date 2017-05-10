//
//  LoginViewController.m
//  BeStronger
//
//  Created by Roy on 17/3/15.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    
   
    
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
    
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"登入";
    self.passwordTextView.secureTextEntry=YES;
    UIBarButtonItem *leftBtnItem=[[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(quxiao)];
    leftBtnItem.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=leftBtnItem;
    
    //用户框和密码框实现协议
    self.userNameTextView.delegate=self;
    self.passwordTextView.delegate=self;
    
    self.userNameTextView.keyboardType=UIKeyboardTypeDefault;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)registerUser:(id)sender {
    
    [self presentViewController:[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"RSex"] animated:YES completion:nil];
}

- (IBAction)retrievePassword:(id)sender {
    
    NSLog(@"忘记密码");
    UIViewController *view=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"fogitPwd"];
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    
    if ([self checkUserNameAndPwd]) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:self.userNameTextView.text,@"phone",self.passwordTextView.text,@"pwd", nil];
        [self showLoaddingTip:@"登入中....." timeOut:0.3f];
        
        //登入
        [[HttpTool sharedInstance] Get:@"/login" params:dic success:^(id responseObj) {
            if ([[responseObj valueForKey:@"code"] isEqualToString:@"200"]) {
                [self showSuccessTip:@"登入成功" timeOut:0.5f];
                NSLog(@"success responseObj:%@",responseObj);
                NSDictionary *obj=[responseObj valueForKey:@"info"];
                [User sharedInstance].userId=[[obj valueForKey:@"id"]intValue];//id
                [User sharedInstance].sport_id=[obj valueForKey:@"sprot_id"];//用户id
                [User sharedInstance].username=[obj valueForKey:@"nickname"];//昵称
                [User sharedInstance].age=[[obj valueForKey:@"age"]intValue];//年龄
                [User sharedInstance].shenGao=[[obj valueForKey:@"height"]floatValue];//身高
                [User sharedInstance].tiZhong=[[obj valueForKey:@"weight"]doubleValue];//体重
                [User sharedInstance].realName=[obj valueForKey:@"realName"];//真实姓名
                [User sharedInstance].bmi=[obj valueForKey:@"bmi"];
                [User sharedInstance].sex=[[obj valueForKey:@"sex"]intValue];
                [User sharedInstance].birthday=[obj valueForKey:@"birthDay"];
                NSString *advice=[obj valueForKey:@"advice"];
                [User sharedInstance].healthAdvice=[obj valueForKey:@"advice"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            if ([[responseObj valueForKey:@"code"] isEqualToString:@"404"]) {
                [self showMessageTip:[responseObj valueForKey:@"info"] detail:nil timeOut:0.3];
            }
            
            
        } failure:^(NSError *error) {
            [self showFailureTip:@"登录失败" detail:nil timeOut:2.0f];
            NSLog(@"failure:%@",error);
        }];
    }
   }

-(BOOL)checkUserNameAndPwd
{
    NSString *userName=self.userNameTextView.text;
    if ((NULL==userName)||[userName isEqualToString:@""]) {
        [self showMessageTip:@"请输入电话号码" detail:nil timeOut:0.3];
        return false;
    }
    NSString *pwd=self.passwordTextView.text;
    if ((NULL==pwd)||[pwd isEqualToString:@""]) {
        [self showMessageTip:@"请输入密码" detail:nil timeOut:0.3];
        return false;
    }
    NSLog(@"用户名:%@ 密码:%@",userName,pwd);
    [User sharedInstance].phoneNumber=userName;
    [User sharedInstance].pwd=pwd;
    return true;
}

-(void)quxiao
{

    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark 协议
//uitextFeild
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.userNameTextView==textField) {
        self.userNameTextView=textField;
        [self.userNameTextView resignFirstResponder];
    }
    if (self.passwordTextView==textField) {
        self.passwordTextView=textField;
        [self.passwordTextView resignFirstResponder];
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.returnKeyType=UIReturnKeyDone;
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNameTextView resignFirstResponder];
    [self.passwordTextView resignFirstResponder];
}
@end
