//
//  RegisterHeightController.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeightControllerDelleget <NSObject>

-(void)setSexValue:(int) sexValue withHeight:(float) height;
-(void)setSexValue:(int) sexValue withNickName:(NSString *) nickName  withPhone:(NSString *)phone WithPwd:(NSString *) pwd;

@end


@interface RegisterHeightController : UIViewController

@property(nonatomic,assign) int sexValue;
@property(nonatomic,weak) id<HeightControllerDelleget> delegate;

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UITextField *nickNameFeild;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberFeild;


@property (weak, nonatomic) IBOutlet UITextField *pwdFeild;




- (IBAction)back:(id)sender;

- (IBAction)next:(id)sender;

@end
