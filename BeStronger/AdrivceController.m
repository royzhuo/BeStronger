//
//  AdrivceController.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "AdrivceController.h"

const NSString *cellId=@"cellId";
@interface AdrivceController ()<RegisterBirthDelleget,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    NSMutableDictionary *datas;
    UITextView *textView;
    int mySex;
}

@end

@implementation AdrivceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"注册";
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+100,  self.view.frame.size.width,self.view.frame.size.height-300) style:UITableViewStylePlain];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //tableview.backgroundColor=RGB(255, 248, 220);
    tableview.dataSource=self;
    tableview.delegate=self;
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(0, tableview.frame.origin.y+180, tableview.frame.size.width, tableview.frame.size.height-100)];
    textView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    textView.scrollEnabled=YES;
    textView.delegate=self;
    tableview.tableFooterView=textView;
    [self.view addSubview:tableview];
    datas=[[NSMutableDictionary alloc]init];
    
    //计算bmi
    double bmi=[self getBMIWihtHeight:self.height  weight:self.weight];
    self.bmi=bmi;
    //获取bmi标准信息
    [self getBMIInfo:bmi];
}




#pragma mark 返回上一级
- (IBAction)back:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 注册
- (IBAction)ok:(id)sender {
    NSLog(@"ok");
    
    NSString *sheight=[NSString stringWithFormat:@"%f",self.height];
    NSString *sweight=[NSString stringWithFormat:@"%f",self.weight];
    NSString *sbmi=[NSString stringWithFormat:@"%f",self.bmi];
    self.advice=textView.text;
    
    //拼接数据
    NSDictionary *dic=@{@"height":sheight,
                        @"weight":sweight,
                        @"birthday":self.birthday,
                        @"bmi":sbmi,
                        @"advice":self.advice,
                        @"nickName":self.nickName,
                        @"phone":self.phone,
                        @"pwd":self.pwd,
                        @"sex":[[NSNumber alloc]initWithInt:mySex]
                        };
    
    //网络请求
    [[HttpTool sharedInstance]Post:@"/api/user/register" params:dic success:^(id responseObj) {
        [self showSuccessTip:@"注册成功" timeOut:0.6f];
        if ([[responseObj valueForKey:@"code"] isEqualToString:@"200"]) {
//            UIViewController *viewController=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"login"];
//            [self presentViewController:viewController animated:YES completion:nil];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if ([[responseObj valueForKey:@"code"] isEqualToString:@"500"]){
        [self showFailureTip:@"添加失败" detail:nil timeOut:0.6f];
        }
        
        
        
    } failure:^(NSError *error) {
        [self showFailureTip:@"添加失败" detail:nil timeOut:0.6f];
    }];
}

#pragma mark 计算体标指数
-(double) getBMIWihtHeight:(double ) height weight:(double) weight
{
    double tempHeight=height/100;
    double bmi=weight/(tempHeight*tempHeight);
    
    return bmi;
}
//信息标准
-(void) getBMIInfo:(double) bmi
{
    NSString *finalBmi=[NSString stringWithFormat:@"%.2f",bmi];
    [datas setObject:finalBmi forKey:@"bmia"];
    if (bmi<18.5) {
        textView.text=@"";
        [datas setObject:@"体重过轻" forKey:@"bmiInfo"];
        textView.text=@"建议\n   你的BMI指数偏低，属于偏瘦。建议你饮食方面不要偏食和挑食，可适量增加高蛋白食品（鸡蛋，牛奶，花生等）。摄入足够蛋白质的情况下，宜多进食一些含脂肪、碳水化合物（即淀粉、糖类等）较丰富的食物。每天应抽出一定的时间来锻炼，这不仅有利于改善食欲，也能使肌肉强壮、体魄健美。在运动方式上，建议在跑步机进行慢跑，因为人在慢跑的时候肠胃蠕动次数明显增多，这样可以消耗人体能量，在进餐时胃口就好。";
        
    }else if((18.5<bmi)&&(bmi<24.9)){
        textView.text=@"";
        [datas setObject:@"体重正常" forKey:@"bmiInfo"];
        textView.text=@"建议\n    你的BMI指数正常，是最好的身体状态。建议你还是要通过适当的健身来继续保持这种fit身材，当然男性朋友如果想练出性感人鱼线和健美八块腹肌，女性朋友想拥有前凸后翘S型曼妙身材的话，可以通过专业的运动完善身材的线条及健康的质量。";
    }else if((24.9<bmi)&&(bmi<29.9)){
        textView.text=@"";
        [datas setObject:@"偏胖" forKey:@"bmiInfo"];
        textView.text=@"建议\n    你BMI指数偏胖了，就是说你稍微有点胖了。建议你实行“管的住嘴迈的开腿”的健身方法，少吃零食、甜膩、油炸、油煎之类高热量食物，多吃蔬菜水果和膳食纤维及富含营养但是低热量的食品，同时开始做有氧运动，类似于跑步、健身车、划船器、游泳等，提高代謝速率，加速消耗体内的脂肪和热量。";
    }else if(29.9<bmi){
        textView.text=@"";
        [datas setObject:@"肥胖" forKey:@"bmiInfo"];
        textView.text=@"建议\n    你BMI指数已经超标了，你已经达到肥胖一族的标准。建议不能吃垃圾食品和过于油腻的食物，多吃富含营养但是低热量的食品,例如大豆、绿色蔬菜、无脂或低脂的牛奶、没有添加食用香料和奶精的燕麦片等，不喝酒，不喝饮料，多喝水，每天坚持1个小时以上的中等或高等强度运动，例如跑步、游泳、跳绳、登山等，当然要根据个人实际身体情况，可以一次完成，也可以分次进行。";
    }
    
    
}
#pragma mark 协议


-(void)setSex:(int)sex setHeight:(float)height setWeight:(double)weight setBirth:(NSString *)birth setNickName:(NSString *)nickName setPhone:(NSString *)phone setPwd:(NSString *)pwd
{
    self.height=height;
    self.weight=weight;
    self.birthday=birth;
    self.nickName=nickName;
    self.pwd=pwd;
    self.phone=phone;
    mySex=sex;
    
    NSLog(@"sex:%d  height:%f  weight:%f  birth:%@  nickname:%@ pwd:%@ phone:%@",sex,height,weight,birth,nickName,pwd,phone);

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return datas.allKeys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:cellId];
    if(cell==NULL){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSArray *keys=datas.allKeys;
    NSString *key=[keys objectAtIndex:indexPath.row];
    NSString *value=[datas objectForKey:key];
    if ([key isEqualToString:@"bmia"]) {
        cell.textLabel.text=@"身体体标指数";
    }
    if ([key isEqualToString:@"bmiInfo"]) {
        cell.textLabel.text=@"身体状态";
    }
    cell.detailTextLabel.text=value;
    return cell;
}

//textView
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
