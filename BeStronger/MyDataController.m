//
//  MyDataController.m
//  BeStronger
//
//  Created by Roy on 17/5/1.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyDataController.h"

@interface MyDataController ()

@end

@implementation MyDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的数据";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
