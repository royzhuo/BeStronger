//
//  FirstViewController.m
//  BeStronger
//
//  Created by Roy on 17/3/14.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "FirstViewController.h"
#import "MenuView.h"
#import "NextViewController.h"
#import "MyMapViewController.h"

@interface FirstViewController ()



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"运动空间";
    CGRect frmae=self.view.frame;
    
    self.firstDataView.layer.borderWidth=3;
    self.firstDataView.layer.borderColor=[RGB(248, 248, 255)CGColor];
    
    self.sportView.layer.borderColor=[RGB(248, 248, 255) CGColor];
    self.sportView.layer.borderWidth=2;
    
    self.foodView.layer.borderWidth=2;
    self.foodView.layer.borderColor=[RGB(248, 248, 255) CGColor];
    
    //健康 Healthkit
    BOOL isSupportHealthOfDevice=[HKHealthStore isHealthDataAvailable];
    if (isSupportHealthOfDevice) {
        self.healthStore=[[HKHealthStore alloc]init];
        //获取用户授权
        //1.封装数据用于app将要从数据库中读取的几项数据
        NSSet *readObjectTypes=[NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
        //2.发送请求授权
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (success==YES) {
                //授权成功
                //获取步数
                HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
                NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
                HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                    if(!error && results) {
                        for(HKQuantitySample *samples in results) {
                            NSLog(@"%@ 至 %@ : %@", samples.startDate, samples.endDate, samples.quantity);
                        }
                    } else {
                        //error
                    }
                }];
                [self.healthStore executeQuery:sampleQuery];
            }else{
                //授权失败
                
            }
        }];
    }else{
        [self showMessageTip:@"该设备不支持获取健康数据" detail:nil timeOut:0.3f];
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 跑步
- (IBAction)run:(id)sender {
    MyMapViewController *runView=[StoryBoardController initViewControllerWithStoryBoardName:@"FirstViewStory" withViewId:@"runView"];
    [self.navigationController pushViewController:runView animated:YES];
}
@end
