//
//  TimeTool.m
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "TimeTool.h"


@implementation TimeTool
//DEF_SINGLETON(TimeTool)

+(NSString *)longToDate:(long)longTime
{
    NSDate *dateTime = [[NSDate alloc] initWithTimeIntervalSince1970:longTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *formatterLocal = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    [formatter setLocale:formatterLocal];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:dateTime];
    return dateString;

}

+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
   NSString *dateString= [formatter stringFromDate:date];
    return dateString;

}

#pragma mark 验证电话号码
+(BOOL)checkPhone:(NSString *) phone
{
    
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
    //    NSString * CT = @"^1((33|53|8|7[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    //    BOOL res2 = [regextestcm evaluateWithObject:phone];
    //    BOOL res3 = [regextestcu evaluateWithObject:phone];
    //    BOOL res4 = [regextestct evaluateWithObject:phone];
    
    if (res1 ) {
        return YES;
    } else {
        return NO;
    }
}


@end
