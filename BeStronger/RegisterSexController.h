//
//  RegisterSexController.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistDeleget.h"

@interface RegisterSexController : UIViewController

@property(assign,nonatomic) id<RegistDeleget> deleget;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;

@property (weak, nonatomic) IBOutlet UIButton *boyBtn;

- (IBAction)level:(id)sender;


- (IBAction)selectGirl:(id)sender;

- (IBAction)selectBoy:(id)sender;


@end
