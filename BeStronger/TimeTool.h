//
//  TimeTool.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TimeTool : NSObject
//AS_SINGLETON(TimeTool)

+(NSString *)longToDate:(long) longTime;
+(NSString *)dateToString:(NSDate *)date;
+(BOOL)checkPhone:(NSString *) phone;
@end
