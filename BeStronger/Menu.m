//
//  Menu.m
//  BeStronger
//
//  Created by Roy on 17/3/16.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "Menu.h"

@implementation Menu

+(id)initMenuWithTitle:(NSString *)titleName withImageName:(NSString *)imageName withDetail:(NSString *)detailInfo
{

    Menu *menu=[[Menu alloc]init];
    menu.title=titleName;
    menu.imageName=imageName;
    menu.detailInfo=detailInfo;
    return menu;
}
@end
