//
//  HttpTool.m
//  BeStronger
//
//  Created by Roy on 16/11/30.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool
DEF_SINGLETON(HttpTool)


-(void)Get:(NSString *)url parameters:(NSMutableDictionary *)dic
{
    
    NSString *finalUrl=nil;
    if (url==nil||[url isEqualToString:@""]) {
        finalUrl=self.baseUrl;
    }else finalUrl=[NSString stringWithFormat:@"%@/%@",self.baseUrl,url];
    if (dic==nil||[dic count]==0 ) {
        
    }
    
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json; charset=UTF-8"];
    
    
    
    [manager GET:finalUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    

}

@end
