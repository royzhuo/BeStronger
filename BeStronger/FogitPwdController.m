//
//  FogitPwdController.m
//  BeStronger
//
//  Created by Roy on 17/4/24.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "FogitPwdController.h"

@interface FogitPwdController ()
{

    UIDatePicker *datePicker;
    NSDate *finalDate;
    BOOL isClick;
    UIView *dateView;
    NSString *dateString;
}

@end

@implementation FogitPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"信息确认";
    self.commitBtn.layer.cornerRadius=8.0f;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"离开" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    self.phoneTextFeild.keyboardType=UIKeyboardTypePhonePad;

  
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //1.添加点击事件
    UITapGestureRecognizer *labelTagGest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openDatePick)];
    //2.添加点击事件
    [self.birthLabel addGestureRecognizer:labelTagGest];//添加
    //3.设置label可被点击
    self.birthLabel.userInteractionEnabled=YES;
    
    self.birthLabel.layer.cornerRadius=8.0f;
    self.birthLabel.layer.borderWidth=0.2f;
    self.birthLabel.layer.borderColor=[[UIColor grayColor]CGColor];
    
    
    //创建日期空间
    dateView=[[UIView alloc]initWithFrame:CGRectMake(-300, 258, 260, 200)];
    [self.view addSubview:dateView];
    
    //时间确定按钮
    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.frame=CGRectMake(0, 20, 40, 35);
    [confirmBtn setBackgroundColor:RGB(172, 255, 47)];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    confirmBtn.layer.cornerRadius=8;
    [confirmBtn addTarget:self action:@selector(commitTime) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview:confirmBtn];
    
    
    //时间取消按钮
    UIButton *disBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [disBtn setTitle:@"取消" forState:UIControlStateNormal];
    disBtn.frame=CGRectMake(220, 20, 40, 35);
    [disBtn setBackgroundColor:[UIColor redColor]];
    [disBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    disBtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    disBtn.layer.cornerRadius=8;
    [disBtn addTarget:self action:@selector(disDateView) forControlEvents:UIControlEventTouchUpInside];
    [dateView addSubview:disBtn];
    
    
    //日期选择器
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 60, 260, 150)];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ] ;
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:datePicker];
    
    isClick=NO;

    

}







#pragma mark 关于时间控件

-(void) openDatePick
{
    
    NSLog(@"label被点击了");
    if (isClick==NO) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            dateView.alpha=0.1;
            CGPoint center=dateView.center;
            center.x+=330;
            dateView.center=center;
            
            CGPoint btnCenter=self.commitBtn.center;
            btnCenter.y+=200;
            self.commitBtn.center=btnCenter;
            
        } completion:^(BOOL finished) {
            
            dateView.alpha=1;
            isClick=YES;
            
        }];
        
    }
    
}
-(void)datePickerValueChange:(id) sender
{

    UIDatePicker *datePick=(UIDatePicker *)sender;
    finalDate= datePicker.date;

}


-(void)commitTime
{
    NSLog(@"确定时间");
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint btnCenter=self.commitBtn.center;
        btnCenter.y-=200;
        self.commitBtn.center=btnCenter;
        
        CGPoint center=dateView.center;
        center.x-=330;
        dateView.center=center;
        dateString=  [TimeTool dateToString:finalDate];
        self.birthLabel.text=dateString;
        
    } completion:^(BOOL finished) {
        isClick=NO;
    }];
    

}

-(void)disDateView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        dateView.alpha=1;
        CGPoint center=dateView.center;
        center.x-=330;
        dateView.center=center;
        
        CGPoint btnCenter=self.commitBtn.center;
        btnCenter.y-=200;
        self.commitBtn.center=btnCenter;
        
    } completion:^(BOOL finished) {
        
        dateView.alpha=0.1;
        self.birthLabel.text=@"请点击选择时间";
        isClick=NO;
        
    }];

}

#pragma mark 返回
-(void) back
{
[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 提交
- (IBAction)commitInfo:(id)sender
{
    if ([self checkParam]) {
        
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextFeild.text,@"phone",dateString,@"birth", nil];
        [[HttpTool sharedInstance] Get:@"/api/user/findUser" params:params success:^(id responseObj) {
            if (responseObj) {
                if ([[responseObj valueForKey:@"code"] isEqualToString:@"200_404"]) {
                    [self showMessageTip:@"查无此用户" detail:nil timeOut:0.3];
                    char *result=[[responseObj valueForKey:@"result"]UTF8String] ;
                    NSString *aa=[NSString stringWithUTF8String:result];
                    
                }else if([[responseObj valueForKey:@"code"] isEqualToString:@"200"]){
                    [self showMessageTip:@"查询成功" detail:nil timeOut:0.3];
                    NSDictionary *obj=[responseObj valueForKey:@"result"];
                    int id1=[[obj valueForKey:@"id"]intValue];
                    [User sharedInstance].userId=[[obj valueForKey:@"id"] intValue];
                    
                    UIViewController *view=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"updatePwd"];
                    [self.navigationController pushViewController:view animated:YES];
                }
                
            }
        } failure:^(NSError *error) {
            if (error) {
                [self showMessageTip:@"查询失败" detail:nil timeOut:0.3];
            }
        }];
       

    }
}

-(BOOL) checkParam
{

    
    if ([self.phoneTextFeild.text isEqualToString:@""]) {
        [self showMessageTip:@"请填写手机号后" detail:nil timeOut:0.3];
        return false;
    }
    if (finalDate==nil) {
        [self showMessageTip:@"出生日期不能为空" detail:nil timeOut:0.3];
        return false;
    }
    if ([TimeTool checkPhone:self.phoneTextFeild.text]==false) {
        [self showMessageTip:@"请填写正确手机号码" detail:nil timeOut:0.3];
        return false;
    }
    return true;
}
@end
