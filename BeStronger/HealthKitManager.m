//
//  HealthKitManager.m
//  BeStronger
//
//  Created by Roy on 17/5/10.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "HealthKitManager.h"

@implementation HealthKitManager
DEF_SINGLETON(HealthKitManager)


//判断系统是否支持
-(void)isSupportHealthOfSystemW:(void (^)(BOOL, NSError *))compltion
{
    double systemVersion=[[[UIDevice currentDevice]systemVersion]doubleValue];
    if (systemVersion>=8.0) {
        compltion(true,nil);
    }else {
        NSError *error=[NSError errorWithDomain:@"org.roy.BeStronger" code:2 userInfo:[NSDictionary dictionaryWithObject:@"系统版本要大于8.0" forKey:@"error"]];
        compltion(false,error);
    }

}

//判断设备是否支持
-(void)isSupportHealthOfDevice:(void (^)(BOOL, NSError *))compltion
{
    if ([HKHealthStore isHealthDataAvailable]) {
        //获取用户授权
        //1.封装数据用于app将要从数据库中读取的几项数据
        NSSet *readObjectTypes=[NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
        //2.发送请求授权
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (success==YES) {
                //授权成功
                compltion(success,error);
                
            }else{
                //授权失败
                [self showFailureTip:@"授权失败" detail:nil timeOut:0.3f];
            }
        }];
    }
}

//获取当天步数
-(void)getStepOfTodayWith:(void (^)(double, NSError *))compltion
{
    //查询样本
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //排序
    NSSortDescriptor *end=[NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:YES];
    
    //获取当前时间的步数
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
    
    HKSampleQuery *sampleQuery =[[HKSampleQuery alloc]initWithSampleType:sampleType predicate:[HealthKitManager predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (error) {
            compltion(0,error);
        }else{
            double totalStep=0;
            for (HKQuantitySample *quantitySample in results) {
                HKQuantity *quantity=quantitySample.quantity;
                HKUnit *height=[HKUnit countUnit];
                double userHeight=[quantity doubleValueForUnit:height];
                totalStep+=userHeight;
            }
            NSLog(@"当天步行＝%f",totalStep);
            compltion(totalStep,error);
        }
    }];
    [self.healthStore executeQuery:sampleQuery];

}

+ (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}
@end
