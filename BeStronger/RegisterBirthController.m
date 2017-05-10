//
//  RegisterBirthController.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "RegisterBirthController.h"
#import "AdrivceController.h"

@interface RegisterBirthController ()<WeightControllerDelleget>
{
    UIView *dateView;
    CGFloat x;
    CGFloat y;
    UIDatePicker *datePicker;
    NSDate *finalDate;
    BOOL isClick;
    
    

}
@end

@implementation RegisterBirthController


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置样式
    self.birthLabel.layer.borderWidth=1;
    self.birthLabel.layer.borderColor=[UIColor blackColor].CGColor;
    self.birthLabel.layer.cornerRadius=20;
    //设置启动显示时间空间
    
    //1.添加点击事件
    UITapGestureRecognizer *labelTagGest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openDatePicker)];
    //2.添加点击事件
    [_birthLabel addGestureRecognizer:labelTagGest];//添加
    //3.设置label可被点击
    self.birthLabel.userInteractionEnabled=YES;
    
    //创建日期空间
    dateView=[[UIView alloc]initWithFrame:CGRectMake(-300, 270, 260, 200)];
   // dateView.backgroundColor=[UIColor yellowColor];
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
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 60, 260, 160)];
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
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:datePicker];

    isClick=NO;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
        //[self.view addSubview:datePicker];
    
   self.navigationItem.title=@"生日";
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)back:(id)sender {
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    AdrivceController *adriveController=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"MB"];
    self.delleget=adriveController;
    if ([self.birthLabel.text isEqualToString:@""]) {
        [self showMessageTip:nil detail:@"请选择日期" timeOut:0.8];
        return;
    }
    [self.delleget setSex:self.sex setHeight:self.height setWeight:self.weight setBirth:self.birthLabel.text setNickName:self.nickName setPhone:self.phone setPwd:self.pwd];
   // [self presentViewController:adriveController animated:YES completion:nil];
    [self.navigationController pushViewController:adriveController animated:YES];
}

#pragma mark 协议

-(void)setWeight:(double)weight setSex:(int)sex setHeight:(float)height setNickName:(NSString *)nickName setPhone:(NSString *)phone setPwd:(NSString *)pwd
{
    self.sex=sex;
    self.height=height;
    self.weight=weight;
    self.nickName=nickName;
    self.phone=phone;
    self.pwd=pwd;
}

#pragma mark datePickEvent

-(void) openDatePicker
{
    NSLog(@"label被点击了");
    if (isClick==NO) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            dateView.alpha=0.1;
            CGPoint center=dateView.center;
            center.x+=330;
            dateView.center=center;
            
        } completion:^(BOOL finished) {
            
            dateView.alpha=1;
            isClick=YES;
            
        }];

    }
    
    
}
-(void)datePickerValueChanged:(id)sender
{
    UIDatePicker *datePick=(UIDatePicker *)sender;
    finalDate= datePicker.date;
   
}

//确定时间
-(void)commitTime
{
    NSLog(@"确定时间");
   NSString *dateString=  [TimeTool dateToString:finalDate];
    self.birthLabel.text=dateString;
}
//取消隐藏视图
-(void)disDateView
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        dateView.alpha=1;
        CGPoint center=dateView.center;
        center.x-=330;
        dateView.center=center;
        
    } completion:^(BOOL finished) {
        
        dateView.alpha=0.1;
        self.birthLabel.text=@"";
        isClick=NO;
        
    }];

}

@end
