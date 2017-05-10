//
//  User.m
//  BeStronger
//
//  Created by Roy on 17/3/16.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "User.h"

@implementation User
DEF_SINGLETON(User)


-(void)cleanUser
{

    self.userId=nil;
    self.sport_id=nil;
    self.username=nil;
    self.age=nil;
    self.birthday=nil;
    self.bmi=nil;
    self.shenGao=0;
    self.tiZhong=0;
    self.sex=0;
    self.healthAdvice=nil;
}
@end
