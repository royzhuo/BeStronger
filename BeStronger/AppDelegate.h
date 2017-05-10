//
//  AppDelegate.h
//  BeStronger
//
//  Created by Roy on 16/11/23.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class RootViewController;
@class FirstViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) RootViewController *viewController;

@property (strong, nonatomic) UINavigationController *navgationController;

- (void)saveContext;


@end

