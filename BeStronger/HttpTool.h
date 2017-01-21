//
//  HttpTool.h
//  BeStronger
//
//  Created by Roy on 16/11/30.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
AS_SINGLETON(HttpTool)

@property(nonatomic,strong) NSString *baseUrl;

-(void) Get:(NSString *) url parameters:(NSDictionary *) dic;

@end
