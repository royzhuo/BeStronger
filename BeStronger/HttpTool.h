//
//  HttpTool.h
//  BeStronger
//
//  Created by Roy on 16/11/30.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequestMethodType){
    RequestMethodTypeGet=1,
    RequestMethodTypePost=2

} ;

@interface HttpTool : NSObject
AS_SINGLETON(HttpTool)

@property(nonatomic,strong) NSString *baseUrl;


-(void) Get:(NSString *) url parameters:(NSDictionary *) dic;

- (void)Get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)Post:(NSString *)url params:(id)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

- (void)Post:(NSString *)url params:(id)params success200And500:(void(^)(id responseObj))success  failure:(void(^)(NSError *error))failure;

-(void)file:(NSData *) fileData post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//上传 单张图片
- (void) uploadImage:(NSData *) image post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//多图上传
-(void)imageUpload:(NSArray *) imgArray post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
