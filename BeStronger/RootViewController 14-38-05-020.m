//
//  RootViewController.m
//  JKSideSlipView
//
//  Created by Jakey on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "RootViewController.h"
#import "MenuView.h"
#import "NextViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"运动";
    self.topview.backgroundColor=RGB(154, 205, 50);
    
    _sideSlipView = [[JKSideSlipView alloc]initWithSender:self];
    _sideSlipView.backgroundColor = [UIColor redColor];
    
    CGRect sideSlipViewRect=_sideSlipView.frame;
    NSLog(@"sideSlipView is %@",_sideSlipView);
    
    
    
    MenuView *menu = [MenuView menuView];
    [menu didSelectRowAtIndexPath:^(id cell, NSIndexPath *indexPath) {
        NSLog(@"click");
        [_sideSlipView hide];
        NextViewController *next = [[NextViewController alloc]init];
        [self.navigationController pushViewController:next animated:YES];
    }];
    menu.items = @[@{@"title":@"运动",@"imagename":@"1"},@{@"title":@"运动定制",@"imagename":@"2"},@{@"title":@"我的运动",@"imagename":@"个人信息"},@{@"title":@"我的健康",@"imagename":@"4"}];
    [_sideSlipView setContentView:menu];
    [self.view addSubview:_sideSlipView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)switchTouched:(id)sender {
    [_sideSlipView switchMenu];
    
}
@end
