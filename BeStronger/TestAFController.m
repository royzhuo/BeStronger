//
//  TestAFController.m
//  BeStronger
//
//  Created by Roy on 16/11/30.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "TestAFController.h"

@interface TestAFController ()

@end

@implementation TestAFController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"sss");
    UIButton *testListButton=[UIButton buttonWithType:UIButtonTypeCustom];
    testListButton.frame=CGRectMake(100, 100, 100, 100);
    [testListButton setTitle:@"ListEmp" forState:UIControlStateNormal];
    testListButton.backgroundColor=[UIColor blueColor];
    [testListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testListButton addTarget:self action:@selector(showListData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testListButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showListData
{

//    [[HttpTool sharedInstance] Get:@"testEmp?id=10" parameters:nil];
    [[HttpTool sharedInstance] Get:@"testEmpList" parameters:nil];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
