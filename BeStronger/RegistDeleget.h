//
//  RegistProtocol.h
//  BeStronger
//
//  Created by Roy on 17/4/9.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistDeleget <NSObject>

-(void) setSexValue:(int) sexValue withSetHeightValue:(float) heightValue withSetWeight:(double) weight;
@end
