//
//  RegistWeightController.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "RegistWeightController.h"
#import "RegisterBirthController.h"

@interface RegistWeightController ()<HeightControllerDelleget,UITableViewDataSource>

@end

@implementation RegistWeightController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"体重和身高";
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];


}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    [self.view endEditing:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)back:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    NSString *weight=self.weightTextField.text;
    NSString *height=self.heightFeild.text;
    if ([weight isEqualToString:@""]) {
        [self showMessageTip:@"请填写体重" detail:nil timeOut:1.5f];
        return;
    }
    double weightd=[weight doubleValue];
    if ([height isEqualToString:@""]) {
        [self showMessageTip:@"请填写身高" detail:nil timeOut:1.5f];
        return;
    }
    
    float heightd=[height floatValue];
    
    
    RegisterBirthController *birthController=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"RB"];
    self.delleget=birthController;
    [self.delleget setWeight:weightd setSex:self.sex setHeight:heightd setNickName:self.nickName setPhone:self.phone setPwd:self.pwd];
    //[self presentViewController:birthController animated:YES completion:nil];
    [self.navigationController pushViewController:birthController animated:YES];
}


#pragma mark 协议


-(void)setSexValue:(int)sexValue withNickName:(NSString *)nickName withPhone:(NSString *)phone WithPwd:(NSString *)pwd
{
    self.sex=sexValue;
    self.nickName=nickName;
    self.pwd=pwd;
    self.phone=phone;
}

@end
