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
   NSString *viersion= [UIDevice currentDevice].systemVersion;
    NSLog(@"%@",viersion);
    
    
    
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


#pragma mark get请求
-(void)Get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    [self requestWihtMethod:RequestMethodTypeGet url:url params:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

#pragma mark post请求
-(void)Post:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //由于新增loginId故在此新加一个字典
    NSMutableDictionary * dic = nil;
    
    NSString * Url = @"";
    if (params != nil) {
        
        if ([params isKindOfClass:[NSString class]] ) {
            Url = [NSString stringWithFormat:@"%@%@",url,params];
            dic = [NSMutableDictionary dictionary];
        }
        else{
            Url = url;
            dic = [NSMutableDictionary dictionaryWithDictionary:params];
        }
        
    }
    else{
        Url = url;
        dic = [NSMutableDictionary dictionary];
    }

    [self requestWihtMethod:RequestMethodTypePost url:url params:dic success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];


}

//上传单张图片
-(void)uploadImage:(NSData *)image post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 20.5f;
    [manager POST:[NSString stringWithFormat:@"%@%@",self.baseUrl,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 设置时间格式
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:image name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

//上传多张图片
-(void)imageUpload:(NSArray *)imgArray post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 20.5f;
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    if (imgArray!=nil&&imgArray.count>0) {
               [manager POST:[NSString stringWithFormat:@"%@%@",_baseUrl,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                   for (int i =0;i<imgArray.count;i++) {
                       if ([imgArray[i] isKindOfClass:[NSData class]]) {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           
                           // 设置时间格式
                           
                           formatter.dateFormat = @"yyyyMMddHHmmss";
                           
                           NSString *str = [formatter stringFromDate:[NSDate date]];
                           
                           NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                           
                           
                           if (imgArray[i] != NULL) {
                               
                               [formData appendPartWithFileData:imgArray[i] name:@"file" fileName:fileName mimeType:@"image/png"];
                               
                               
                           }

                       }
                   }

        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"success:%@",responseObject);
            if (success) {
                success(responseObject);
            }
        } failure:nil];
    }
    
    
     
}






#pragma mark 网络请求
- (void)requestWihtMethod:(RequestMethodType)methodType
                      url:(NSString*)url
                   params:(id)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError* err))failure
{
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //是否信任服务器无效或过期的SSL证书。默认为“不”。
    securityPolicy.allowInvalidCertificates = YES;
    //是否验证域名证书的CN字段。默认为“是”。
    securityPolicy.validatesDomainName = NO;
    
    NSString * Url = [[NSString stringWithFormat:@"%@%@",self.baseUrl,url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"接口%@",Url);
    //获得请求管理者
    //AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    mgr.securityPolicy = securityPolicy;
    
    //设置超时时间
    mgr.requestSerializer.timeoutInterval = 20.5f;
    
    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            //GET请求

            [mgr GET:Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@ error",error);
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            break;
        case RequestMethodTypePost:
        {
            //POST请求
            [mgr POST:Url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"uploadProgress:%@",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }
    
    //    NSURL *Url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.baseUrl,url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    //
    //    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //
    //    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id result) {
    //        NSLog(@"%@",operation);
    //        NSLog(@"Success: %@ ***** %@", operation.responseString, result);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    //    }];
    //    [operation start];
}


@end
