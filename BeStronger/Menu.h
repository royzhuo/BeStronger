//
//  Menu.h
//  BeStronger
//
//  Created by Roy on 17/3/16.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *imageName;
@property(nonatomic,strong) NSString *detailInfo;


+(id ) initMenuWithTitle:(NSString *) titleName withImageName:(NSString *) imageName withDetail:(NSString *) detailInfo;

@end
