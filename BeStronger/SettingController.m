//
//  SettingController.m
//  BeStronger
//
//  Created by Roy on 17/5/1.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menus;
    


}

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    menus=@[@"个人信息修改"];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    
   
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150, self.view.frame.size.width, 80)];
    
    UIButton *tuichuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tuichuBtn.frame=CGRectMake(10, 20,footView.frame.size.width-20, 40);
    tuichuBtn.backgroundColor=RGB(255, 128, 0);
    [tuichuBtn setTitle:@"退出" forState:UIControlStateNormal];
    tuichuBtn.layer.cornerRadius=8.0f;
    [tuichuBtn addTarget:self action:@selector(userOut) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:tuichuBtn];
    self.tableView.tableFooterView=footView;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
}


-(void)userOut
{
    [[User sharedInstance] cleanUser];
    self.tabBarController.selectedIndex=0;

}
#pragma mark tableview 协议


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [menus count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellId=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==NULL) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
     cell.detailTextLabel.text=[menus objectAtIndex:indexPath.row];
    cell.accessoryType=UITableViewCellStyleValue1;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIViewController *viewController=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"myInfoUpdate"];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}



@end
