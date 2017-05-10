//
//  StoryBoardController.m
//  BeStronger
//
//  Created by Roy on 17/3/15.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "StoryBoardController.h"

@interface StoryBoardController ()

@end

@implementation StoryBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(id)initViewControllerWithStoryBoardName:(NSString *)storyName withViewId:(NSString *)identified
{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:storyName bundle:nil];
    UIViewController *view=[storyBoard instantiateViewControllerWithIdentifier:identified];
    return view;
}
@end
