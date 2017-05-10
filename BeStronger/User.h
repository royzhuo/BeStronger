//
//  User.h
//  BeStronger
//
//  Created by Roy on 17/3/16.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
AS_SINGLETON(User);


@property(nonatomic,assign) NSInteger *userId;
@property(nonatomic,strong) NSString *sport_id;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *realName;
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *pwd;
@property(nonatomic,assign) int age;
@property(nonatomic,assign) int sex;//性别 1.女 2.男
@property(nonatomic,assign) float shenGao;//身高
@property(nonatomic,assign) double tiZhong;//体重
@property(nonatomic,assign) double tiZhongBianHua;//体重变化
@property(nonatomic,strong) NSString *phoneNumber;
@property(nonatomic,strong) NSString *health;
@property(nonatomic,strong) NSString *healthAdvice;//健康建议
@property(nonatomic,strong) NSString *bmi;//身体指标


-(void) cleanUser;

@end
