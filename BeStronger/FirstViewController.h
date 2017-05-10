//
//  FirstViewController.h
//  BeStronger
//
//  Created by Roy on 17/3/14.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>


@interface FirstViewController : UIViewController
{
//JKSideSlipView *_sideSlipView;
}


#pragma mark 属性
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *firstDataView;

@property (weak, nonatomic) IBOutlet UIView *sportView;

@property (weak, nonatomic) IBOutlet UIView *foodView;

@property (weak, nonatomic) IBOutlet UIButton *runBtn;

@property (weak, nonatomic) IBOutlet UIButton *runCodeBtn;

@property (weak, nonatomic) IBOutlet UILabel *bushuLabel;


@property (weak, nonatomic) IBOutlet UILabel *goliLabel;

@property (weak, nonatomic) IBOutlet UILabel *qianjiaoLabel;


@property(nonatomic,strong) HKHealthStore *healthStore;

#pragma mark 方法
- (IBAction)run:(id)sender;


@end
