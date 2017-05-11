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

{
    

}

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
    
    NSLog(@"主线程");
    
    //采用gcd多线程加载资源
    dispatch_queue_t queue=dispatch_queue_create("org.roy.BeStronger", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            NSLog(@"start task 1");
            
            //健康 Healthkit
            BOOL isSupportHealthOfDevice=[HKHealthStore isHealthDataAvailable];
            if (isSupportHealthOfDevice) {
                self.healthStore=[[HKHealthStore alloc]init];
                //获取用户授权
                //1.封装数据用于app将要从数据库中读取的几项数据
                NSSet *readObjectTypes=[NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned], nil];
                //2.发送请求授权
                [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
                    if (success==YES) {
                        //授权成功
                        [self getStepCountCurrentDay];
                        [self getDistance];
                        [self getKaLuLiToday];
                    }else{
                        //授权失败
                        [self showFailureTip:@"授权失败" detail:nil timeOut:0.3f];
                    }
                }];
            }else{
                [self showMessageTip:@"该设备不支持获取健康数据" detail:nil timeOut:0.3f];
            }
        });
    
    NSLog(@"在下面在下面");
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 跑步
- (IBAction)run:(id)sender {
    UIViewController *runView=[StoryBoardController initViewControllerWithStoryBoardName:@"FirstViewStory" withViewId:@"runView"];
    [self.navigationController pushViewController:runView animated:YES];
}

#pragma mark healthkit相关业务方法
//获取步数
-(void) getStepCountCurrentDay
{

    //查询样本
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //排序
    NSSortDescriptor *start=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:YES];
    
    //获取当前时间的步数
    
//    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
    
    
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(!error && results) {
//            for(HKQuantitySample *samples in results) {
//                NSLog(@"%@ 至 %@ : %@", samples.startDate, samples.endDate, samples.quantity);
//            }
            
            double totalStep=0;
            for (HKQuantitySample *quantitySample in results) {
                HKQuantity *quantity=quantitySample.quantity;
                HKUnit *height=[HKUnit countUnit];
                double userHeight=[quantity doubleValueForUnit:height];
                totalStep+=userHeight;
                
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"当天步行＝%f",totalStep);
                self.bushuLabel.text=[NSString stringWithFormat:@"%.0f",totalStep];
                [self.healthStore stopQuery:query];
            });
            

        } else {
            //error
        }
    }];
    [self.healthStore executeQuery:sampleQuery];

}

//获取当天运动跑步距离
-(void) getDistance
{
    
    HKSampleType *sampleType=[HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *end=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    NSSortDescriptor *startDate=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];

    HKSampleQuery *query=[[HKSampleQuery alloc]initWithSampleType:sampleType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[startDate,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (!error && results ) {
            double kil=0;
            double sumTime=0;
            for (HKQuantitySample *quantitySample in results) {
                HKQuantity *quantity=quantitySample.quantity;
               HKUnit *kilUnit= [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];//单位
              double userDistance=  [quantity doubleValueForUnit:kilUnit];
                kil+=userDistance;
                NSTimeZone *zone=[NSTimeZone systemTimeZone];
                NSInteger interval=[zone secondsFromGMTForDate:quantitySample.endDate];
                NSDate *startDate=[quantitySample.startDate dateByAddingTimeInterval:interval ];
                NSDate *endDate=[quantitySample.endDate dateByAddingTimeInterval:interval];
                
                sumTime+=[endDate timeIntervalSinceDate:startDate];
            }
            int hour=sumTime/3600;
            int minute=((long)sumTime % 3600)/60;
            
            //计算卡路里
            double k=30/(kil*1000/hour*60+minute);
            double kalu=[User sharedInstance].tiZhong*hour*k;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"今天运动距离:%.2f公里",kil);
                self.goliLabel.text=[NSString stringWithFormat:@"%.2f",kil];
                NSLog(@"今天运动的开路里:%.2f",kalu);
                
                [self.healthStore stopQuery:query];
            });

           
        }
    }];
    [self.healthStore executeQuery:query];


}

//获取当天的卡路里
-(void) getKaLuLiToday
{
//    //获取卡路里样本
//    HKSampleType *kaLuLiType=[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned ];
//    //获取开始时间 结束时间
//    NSSortDescriptor *start=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
//    NSSortDescriptor *end=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
//    HKSampleQuery *query=[[HKSampleQuery alloc]initWithSampleType:kaLuLiType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
//        double knum=0;
//        if (!error&&results) {
//            for (HKQuantitySample *quantitySamp in results) {
//               HKQuantity *quantity= quantitySamp.quantity;
//                HKUnit *kaLuLiUnit=[HKUnit kilocalorieUnit];//卡路里单位
//                knum+=[quantity doubleValueForUnit:kaLuLiUnit];
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"卡路里大卡: %.2f",knum);
//            _qianjiaoLabel.text=[NSString stringWithFormat:@"%.2f",knum];
//            [self.healthStore stopQuery:query];
//        });
//    }];
//    
//    [self.healthStore executeQuery:query];
    
    NSLog(@"获取卡路里");
    double weight=[User sharedInstance].tiZhong;
    

}

//获取某一时间段
-(NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
   NSDate  *startDate = [calendar dateFromComponents:components];
   NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}
@end
