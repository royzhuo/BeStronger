//
//  MyInfoUpdateController.m
//  BeStronger
//
//  Created by Roy on 17/5/8.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyInfoUpdateController.h"

@interface MyInfoUpdateController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray *menuKeys;
    NSMutableArray *infoValues;
    NSMutableArray *danweis;
    
    NSInteger *userId;
    NSString *nickName;
    NSString *sportId;
    int sex;
    NSString *birthDay;
    float height;
    double weight;
    NSString *bmi;
    
    int indexCurrent;


}

@end

@implementation MyInfoUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"信息修改";
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    menuKeys=[NSMutableArray arrayWithObjects:@"昵称:",@"运动号:",@"身高:",@"体重:",@"身体指标:", nil];
    danweis=[NSMutableArray arrayWithObjects:@"cm",@"kg", nil];
    
    userId=[User sharedInstance].userId;
    nickName=[User sharedInstance].username;
    sportId=[User sharedInstance].sport_id;
    sex=[User sharedInstance].sex;
    birthDay=[User sharedInstance].birthday;
    height=[User sharedInstance].shenGao;
    weight=[User sharedInstance].tiZhong;
    bmi=[User sharedInstance].bmi;
    
    
    
    infoValues=[NSMutableArray arrayWithObjects: nickName,sportId,
                [NSString stringWithFormat:@"%f",height],[NSString stringWithFormat:@"%f",weight],bmi,nil];
    
    
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150, self.view.frame.size.width, 80)];
    
    UIButton *tuichuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tuichuBtn.frame=CGRectMake(10, 20,footView.frame.size.width-20, 40);
    tuichuBtn.backgroundColor=RGB(255, 128, 0);
    [tuichuBtn setTitle:@"更新" forState:UIControlStateNormal];
    tuichuBtn.layer.cornerRadius=8.0f;
    [tuichuBtn addTarget:self action:@selector(updateUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:tuichuBtn];
    self.tableView.tableFooterView=footView;
    
    indexCurrent=22;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}


#pragma mark 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [menuKeys count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    UILabel *lable=[cell viewWithTag:1000];
    UITextField *textField=[cell viewWithTag:2000];
    UILabel *danweiLabel=[cell viewWithTag:3000];
    NSLog(@"textField tag is %d",textField.tag);
    
    lable.text=[menuKeys objectAtIndex:indexPath.row];
        [textField setEnabled:NO];
    if ((indexPath.row>1)&&(indexPath.row<4)) {
        danweiLabel.text=[danweis objectAtIndex:indexPath.row-2];
    }
    textField.text=[infoValues objectAtIndex:indexPath.row];
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
   UITextField *textField= [cell viewWithTag:2000];
    NSLog(@"选中了第%d行",indexPath.row);
    if (indexPath.row!=(menuKeys.count-1)&&indexPath.row!=1) {
        [textField setEnabled:YES];
        
        if (indexPath.row==0) {
            
           [textField addTarget:self action:@selector(nickDidChange:) forControlEvents:UIControlEventEditingChanged];
        }
        if (indexPath.row==2) {
            textField.keyboardType=UIKeyboardTypeNumberPad;
            [textField addTarget:self action:@selector(heightDidChange:) forControlEvents:UIControlEventEditingChanged];
        }
        if (indexPath.row==3) {
            textField.keyboardType=UIKeyboardTypeNumberPad;
            [textField addTarget:self action:@selector(weightFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    UITextField *textField= [cell viewWithTag:2000];
    [textField setEnabled:NO];


}

-(void)heightDidChange:(UITextField *)textField
{
    NSLog(@"身高:%@",textField.text);
    NSString *finaHeight=textField.text;
    height=[finaHeight floatValue];
    [self updateBmi];
}
-(void)weightFieldChange:(UITextField *)textField;
{

 NSLog(@"体重:%@",textField.text);
    NSString *finaWeight=textField.text;
    weight=[finaWeight doubleValue];
    [self updateBmi];
}

-(void)nickDidChange:(UITextField *) textField
{
    NSLog(@"昵称:%@",textField.text);
    nickName=textField.text;
}
-(void)updateUserInfo
{
    NSString *finalHeight=[NSString stringWithFormat:@"%.2f",height];
    NSString *finalWeight=[NSString stringWithFormat:@"%.2f",weight];
    NSNumber *userId=[NSNumber numberWithInt:[User sharedInstance].userId];
    NSString *healthAdvice=[User sharedInstance].healthAdvice;
//
//    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:nickName,@"nickName",finalHeight,@"height",finalWeight,@"weight",healthAdvice,@"advice",bmi,@"bmi",userId,@"userId", nil];
    [[HttpTool sharedInstance]Post:@"/api/user/updateUserInfo" params:dic success:^(id responseObj) {
        if ([[responseObj valueForKey:@"code"] isEqualToString:@"200"]) {
            [self showSuccessTip:[responseObj valueForKey:@"message"] timeOut:0.3f];
            NSDictionary *obj=[responseObj valueForKey:@"result"];
            [User sharedInstance].bmi=[obj valueForKey:@"bmi"];
            [User sharedInstance].healthAdvice=[obj valueForKey:@"advice"];
            [User sharedInstance].shenGao=[[obj valueForKey:@"height"]floatValue];
            [User sharedInstance].tiZhong=[[obj valueForKey:@"weight"]doubleValue];
            [User sharedInstance].username=[obj valueForKey:@"nickname"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([[responseObj valueForKey:@"code"] isEqualToString:@"200_500"]) {
            [self showSuccessTip:[responseObj valueForKey:@"message"] timeOut:0.3f];
        }
    } failure:^(NSError *error) {
        if (error) {
            [self showSuccessTip:@"出问题了" timeOut:0.3f];
        }
    }];
    
    
}

-(void)updateBmi
{
    float tempHeight=height/100;
    double tmpbmi=weight/(tempHeight*tempHeight);
    NSString *advice=[AdviecesTool getAdvicesByBmi:tmpbmi];
    [User sharedInstance].healthAdvice=advice;
    if (tempHeight<=0) {
        bmi=@"0";
    }else {
    bmi=[NSString stringWithFormat:@"%.2f",tmpbmi];
    }
    
    NSMutableArray *indexPaths=[[NSMutableArray alloc]init];
    NSInteger index=[menuKeys indexOfObject:@"身体指标:"];
   NSIndexPath *indexPath= [NSIndexPath indexPathForRow:index inSection:0];
    [indexPaths addObject:indexPath];
    
    int replaceIndex=infoValues.count-1;
    [infoValues replaceObjectAtIndex:replaceIndex withObject:bmi];
    
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
}
@end
