//
//  MyInfoViewController.m
//  BeStronger
//
//  Created by Roy on 17/3/15.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyInfoViewController.h"
#import "Menu.h"

@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableDictionary *menuDictionary;


}

@property(nonatomic,strong) NSMutableArray *menus;

@end


@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    CGRect tableViewFrame=self.myTableView.frame;
    NSLog(@"tableView frame:%d",tableViewFrame);
    //self.automaticallyAdjustsScrollViewInsets=NO;
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   self.navigationItem.title=@"我的";
    //self.navigationController.navigationBarHidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark 初始化菜单数据
-(void)initMenusInfo
{
    Menu *menu1=[Menu initMenuWithTitle:@"我的信息" withImageName:@"dongtai_hei" withDetail:nil];
    Menu *menu2=[Menu initMenuWithTitle:@"我的计划" withImageName:@"dongtai_hei" withDetail:nil];
    Menu *menu3=[Menu initMenuWithTitle:@"设置" withImageName:@"dongtai_hei" withDetail:nil];
   // Menu *menu4=[Menu initMenuWithTitle:@"退出" withImageName:@"dongtai_hei" withDetail:nil];
    Menu *menu5=[Menu initMenuWithTitle:@"我的数据" withImageName:@"dongtai_hei" withDetail:nil];
    //Menu *menu6=[Menu initMenuWithTitle:@"个人信息" withImageName:@"个人" withDetail:nil];

    NSArray *menus1=@[menu1,menu2,menu5];
    NSArray *menus2=@[menu3];
   // NSArray *menus3=@[menu4];
    
    menuDictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:menus1,@"1",menus2,@"2", nil];
    
}

#pragma mark 协议

#pragma mark tableview协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self initMenusInfo];
    return menuDictionary.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    
        NSString *key=[NSString stringWithFormat:@"%d",section+1];
       return [[menuDictionary objectForKey:key]count];

   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *cellId=@"cell1";
    UITableViewCell *cellView=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cellView==nil) {
        cellView=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //cell view
    UIImageView *imageView=[cellView viewWithTag:1000];
    UILabel *labelView=[cellView viewWithTag:2000];
    
    
    NSString *key=[NSString stringWithFormat:@"%d",indexPath.section+1];
    NSArray *menus=[menuDictionary objectForKey:key];
    Menu *menu=menus[indexPath.row];
    if (menu) {
        labelView.text=menu.title;
        imageView.image=[UIImage imageNamed:menu.imageName];
    }
    cellView.accessoryType=UITableViewCellStyleValue1;
    return cellView;

}
//行选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   NSLog(@"选择了第%d 组 第%d 行",indexPath.section,indexPath.row);
    
    if (indexPath.section==0&&indexPath.row==0) {
        UIViewController *myInfoView=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"pInfo"];
        [self.navigationController pushViewController:myInfoView animated:YES];
    }
    if (indexPath.section==0&&indexPath.row==1) {
        UIViewController *myInfoView=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"pPlan"];
        [self.navigationController pushViewController:myInfoView animated:YES];
    }

    if (indexPath.section==0&&indexPath.row==2) {
        UIViewController *myInfoView=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"pData"];
        [self.navigationController pushViewController:myInfoView animated:YES];
    }

    if (indexPath.section==1&&indexPath.row==0) {
        UIViewController *myInfoView=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"pSetting"];
        [self.navigationController pushViewController:myInfoView animated:YES];
    }

   }
#pragma mark 懒加载
-(NSMutableArray *)menus
{
    if (_menus==nil) {
        _menus=[[NSMutableArray alloc]init];
    }
    return _menus;

}


@end
