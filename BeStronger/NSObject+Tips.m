//
//  NSObject+Tips.m
//  智能社区
//
//  Created by Roy on 16/3/23.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "NSObject+Tips.h"
#import "MBProgressHUD.h"


@interface Tips_private : NSObject<MBProgressHUDDelegate>
AS_SINGLETON(Tips_private)

-(void)showTTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval mode:(MBProgressHUDMode)mode;
-(void)ttipsDismiss;

@end

@implementation Tips_private
{
    MBProgressHUD *hud;
    
    NSTimer * timer;
}
DEF_SINGLETON(Tips_private)

-(id)init
{
    self = [super init];
    
    if (self) {
        
        hud = [[MBProgressHUD alloc]initWithWindow:[[UIApplication sharedApplication].delegate window]];
        hud.delegate = self;
        hud.minShowTime = 1.f;
    }
    
    return self;
}

-(void)showTTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval mode:(MBProgressHUDMode)mode{
    
    hud.labelText = string;
    hud.detailsLabelText = detail;
    hud.mode = mode;
    
    [hud removeFromSuperview];
    if (hud.superview==nil) {
        [[[UIApplication sharedApplication].delegate window] addSubview:hud];
        
    }
    hud.removeFromSuperViewOnHide = NO;
    [hud.layer removeAllAnimations];
    [hud show:YES];
    
    if (interval == -1) {
        interval = 999;
    }
    
    //[self ttipsDismiss];
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(ttipsDismiss) userInfo:nil repeats:NO];
}

- (void)ttipsDismiss{
    
    hud.removeFromSuperViewOnHide = NO;
    [hud.layer removeAllAnimations];
    [hud hide:YES];
    
    //销毁定时器
    [timer invalidate];
    timer = nil;
}

@end


@implementation NSObject (Tips)

- (void)showMessageTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval{
    
    [[Tips_private sharedInstance] showTTip:string detail:detail timeOut:interval mode:MBProgressHUDModeText];
    
}

- (void)showSuccessTip:(NSString *)string timeOut:(NSTimeInterval)interval
{
    [[Tips_private sharedInstance] showTTip:string detail:nil timeOut:interval mode:MBProgressHUDModeText];
}

- (void)showLoaddingTip:(NSString *)string timeOut:(NSTimeInterval)interval
{
    [[Tips_private sharedInstance] showTTip:string detail:nil timeOut:interval mode:MBProgressHUDModeIndeterminate];
}

- (void)showFailureTip:(NSString *)string detail:(NSString *)detail timeOut:(NSTimeInterval)interval
{
    [[Tips_private sharedInstance] showTTip:string detail:nil timeOut:interval mode:MBProgressHUDModeText];
}

-(void)dissmissTips
{
    [[Tips_private sharedInstance] ttipsDismiss];
    // return YES;
}


@end
