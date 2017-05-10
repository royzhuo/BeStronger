//
//  RegisterSexController.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "RegisterSexController.h"
#import "RegisterHeightController.h"

@interface RegisterSexController ()

@end

@implementation RegisterSexController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"性别";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"离开" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)back
{
[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)level:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectGirl:(id)sender {
    [self.deleget setSexValue:1 withSetHeightValue:0.0f withSetWeight:0.0];
    RegisterHeightController *rh=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"RH"];
    rh.sexValue=1;
    //[self presentViewController:rh animated:YES completion:nil];
    [self.navigationController pushViewController:rh animated:YES];
}

- (IBAction)selectBoy:(id)sender {
    [self.deleget setSexValue:2 withSetHeightValue:0.0f withSetWeight:0.0];
    RegisterHeightController *rh=[StoryBoardController initViewControllerWithStoryBoardName:@"MyInfo" withViewId:@"RH"];
    rh.sexValue=2;
//    [self presentViewController:rh animated:YES completion:nil];
    [self.navigationController pushViewController:rh animated:YES];
}
@end
