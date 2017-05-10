//
//  MyInfoController.m
//  BeStronger
//
//  Created by Roy on 17/5/1.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyInfoController.h"

const static NSString *cellKey=@"cell";

@interface MyInfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSMutableArray *menuKeys;
    NSMutableArray *infoValues;
    
    NSInteger *userId;
    NSString *nickName;
    NSString *sportId;
    int sex;
    NSString *birthDay;
    float height;
    double weight;
    NSString *bmi;
    
}
@end

@implementation MyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的信息";
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    menuKeys=[NSMutableArray arrayWithObjects:@"昵称:",@"运动号:",@"性别:",@"生日:",@"身高:",@"体重:",@"身体指标指数:", nil];
    userId=[User sharedInstance].userId;
    nickName=[User sharedInstance].username;
    sportId=[User sharedInstance].sport_id;
    sex=[User sharedInstance].sex;
    birthDay=[User sharedInstance].birthday;
    height=[User sharedInstance].shenGao;
    weight=[User sharedInstance].tiZhong;
    bmi=[User sharedInstance].bmi;
    
   
    infoValues=[NSMutableArray arrayWithObjects: nickName,sportId,[ NSString stringWithFormat:@"%d",sex],birthDay,
                [NSString stringWithFormat:@"%f",height],[NSString stringWithFormat:@"%f",weight],bmi, nil];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}

#pragma mark 身体指标指数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuKeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellKey];
    if (cell==NULL) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellKey];
    }
    
    if (indexPath.row==2) {
        id sexTemp= [infoValues objectAtIndex:2];
        if ([sexTemp isEqualToString:@"1"]) {
             cell.textLabel.text=[menuKeys objectAtIndex:indexPath.row];
            cell.detailTextLabel.text=@"女";
        }else if ([sexTemp isEqualToString:@"2"]){
             cell.textLabel.text=[menuKeys objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=@"男";
        }
    }else {
        cell.textLabel.text=[menuKeys objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=[infoValues objectAtIndex:indexPath.row];
    }
    
    
    return cell;

}




@end
