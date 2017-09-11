//
//  TNHttpTool.m
//  BaseProject
//
//  Created by Tony on 2017/8/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNHttpTool.h"
#import <AFNetworking.h>
#import "TNPromptBox.h"

NSString * const TNNetworkReachabilityDidChangeNotification = @"networking.reachability.statue.change";
NSString * const TNNetworkReachabilityNotificationStatusItem = @"TNNetworkReachabilityNotificationStatusItem";

//private variable
static NSInteger const kNonNet = 51;
static NSString * const kNetWorkErrorPromptText = @"网络出错";
static NSTimeInterval const kTimeOutInterval = 8.0f;

//the switch whether the normal http manager have security;
static BOOL const hasSecurity = NO;
static BOOL const hasCookied = NO;


static TNHttpTool *httpTool;
static AFHTTPSessionManager *httpNormalManager;
static AFHTTPSessionManager *httpSecurityManager;
static AFNetworkReachabilityManager *reachabilityManager;



@implementation TNHttpTool

+(TNNetWorkState)currentNetWorkStates{
    AFNetworkReachabilityStatus status = reachabilityManager.networkReachabilityStatus;
    TNNetWorkState tState = (int)status;
    return tState;
}


+(void)initialize{
    
    //检测网络状态
    reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        TNNetWorkState tState = (int)status;
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *postUserInfo = @{ TNNetworkReachabilityNotificationStatusItem: @(tState) };
        [notificationCenter postNotificationName:TNNetworkReachabilityDidChangeNotification object:nil userInfo:postUserInfo];
    }];
    
    [reachabilityManager startMonitoring];
    
    
    //不加密
    httpNormalManager = [AFHTTPSessionManager manager];
    httpNormalManager.responseSerializer = [AFJSONResponseSerializer serializer];
    httpNormalManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //设置超时
    [httpNormalManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    httpNormalManager.requestSerializer.timeoutInterval = kTimeOutInterval;
    [httpNormalManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    //加密
    httpSecurityManager = [AFHTTPSessionManager manager];
    httpSecurityManager.responseSerializer = [AFJSONResponseSerializer serializer];
    httpSecurityManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = NO;
    httpSecurityManager.securityPolicy = securityPolicy;
    
    //设置超时
    [httpSecurityManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    httpSecurityManager.requestSerializer.timeoutInterval = kTimeOutInterval;
    [httpSecurityManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
//    
//    //设置公用请求头参数
//    [self setHttpRequestHeaderFields:@{@"Content-Type":@"application/x-www-form-urlencoded"} security:NO];
//    [self setHttpRequestHeaderFields:@{@"charset":@"UTF-8"} security:NO];
}


+ (void)setHttpRequestHeaderFields:(NSDictionary *)fileds security:(BOOL)security{
    if (security) {
        for (NSString *key in fileds) {
            NSString *value = [fileds valueForKey:key];
            [httpSecurityManager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }else{
        for (NSString *key in fileds) {
            NSString *value = [fileds valueForKey:key];
            [httpNormalManager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
}

+ (void)clearCustomRequestHeaderWithKeys:(NSArray *)keys security:(BOOL)security{
    if (security) {
        for (NSString *key in keys) {
            [httpSecurityManager.requestSerializer setValue:nil forHTTPHeaderField:key];
        }
    }else{
        for (NSString *key in keys) {
            [httpNormalManager.requestSerializer setValue:nil forHTTPHeaderField:key];
        }
    }
}

//base http/get
+ (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(id json))success
                      failure:(void (^)(NSError *error))failure{
    if ([self currentNetWorkStates] == TNNetWorkStateNotReachable) {
        if (failure) {
            NSError *err = [NSError errorWithDomain:@"localhost" code:kNonNet userInfo:nil];
            failure(err);
            [TNPromptBox showPromptBoxWithWords:kNetWorkErrorPromptText toView:nil];
        }
        return nil;
    }
    
    
    NSMutableDictionary *cookiedParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (hasCookied) {
        
        //add your's cookie params dictionary
        NSDictionary *cookieParams = @{};
        [cookiedParams addEntriesFromDictionary:cookieParams];
    }
    AFHTTPSessionManager *mgr = hasSecurity ? httpSecurityManager : httpNormalManager;
    
    
    return [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
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

/**
 * base http/post
 */
+ (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id json))success
                       failure:(void (^)(NSError *error))failure{
    
    
    if ([self currentNetWorkStates] == TNNetWorkStateNotReachable) {
        if (failure) {
            NSError *err = [NSError errorWithDomain:@"localhost" code:kNonNet userInfo:nil];
            failure(err);
            [TNPromptBox showPromptBoxWithWords:kNetWorkErrorPromptText toView:nil];
        }
        return nil;
    }

    
    NSMutableDictionary *cookiedParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (hasCookied) {
        
        //add your's cookie params dictionary
        NSDictionary *cookieParams = @{};
        [cookiedParams addEntriesFromDictionary:cookieParams];
    }
    AFHTTPSessionManager *mgr = hasSecurity ? httpSecurityManager : httpNormalManager;
    
    
    return [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TNPromptBox showPromptBoxWithWords:@"服务器连接失败"];
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  get请求--带cookie, https
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 *  @param enabled 是否使用cookied
 */

+ (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *)params
                      cookied:(BOOL)enabled
                     security:(BOOL)security
                      success:(void (^)(id json))success
                      failure:(void (^)(NSError *error))failure{
    if ([self currentNetWorkStates] == TNNetWorkStateNotReachable) {
        if (failure) {
            NSError *err = [NSError errorWithDomain:@"localhost" code:kNonNet userInfo:nil];
            failure(err);
            [TNPromptBox showPromptBoxWithWords:kNetWorkErrorPromptText toView:nil];
        }
        return nil;
    }
    
    NSMutableDictionary *cookiedParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (enabled) {
        
        //add your's cookie params dictionary
        NSDictionary *cookieParams = @{};
        [cookiedParams addEntriesFromDictionary:cookieParams];
    }
    
    
    AFHTTPSessionManager *mgr = security ? httpSecurityManager : httpNormalManager;
    return [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
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


/**
 *  post请求--带cookie, https
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 *  @param enabled 是否使用cookied
 *  @param security 是否使用https
 */
+ (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                       cookied:(BOOL)enabled
                      security:(BOOL)security
                       success:(void (^)(id json))success
                       failure:(void (^)(NSError *error))failure{
    if ([self currentNetWorkStates] == TNNetWorkStateNotReachable) {
        if (failure) {
            NSError *err = [NSError errorWithDomain:@"localhost" code:kNonNet userInfo:nil];
            failure(err);
            [TNPromptBox showPromptBoxWithWords:kNetWorkErrorPromptText toView:nil];
        }
        return nil;
    }
    NSMutableDictionary *cookiedParams = [NSMutableDictionary dictionaryWithDictionary:params];
    if (enabled) {
        //add your's cookie params dictionary
        NSDictionary *cookieParams = @{};
        [cookiedParams addEntriesFromDictionary:cookieParams];
    }
    
    // 2.发送请求
    AFHTTPSessionManager *mgr = security ? httpSecurityManager : httpNormalManager;
    return [mgr POST:url parameters:cookiedParams progress:^(NSProgress * _Nonnull uploadProgress) {
        
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

#pragma mark upload function

/**
 上传数据
 @param dataArray 数据
 @param dataTypeName 数据种类标注 用于后台识别
 @param fileNameSuffix 保存的文件名后缀 eg. jpg, mp4
 @param mimeType 数据类型 eg. image/jpeg, video/mpeg4,
 */
+ (NSURLSessionDataTask *)uploadDataWithUrl:(NSString *)url
                                     params:(NSDictionary *)params
                                  dataArray:(NSArray *)dataArray
                               dataTypeName:(NSString *)dataTypeName
                             fileNameSuffix:(NSString *)fileNameSuffix
                                   mimeType:(NSString *)mimeType
                                   progress:(void (^) (NSProgress *))progress
                                    success:(void (^)(id))success
                                    failure:(void (^)(NSError *))failure
{
    if ([self currentNetWorkStates] == TNNetWorkStateNotReachable) {
        if (failure) {
            NSError *err = [NSError errorWithDomain:@"localhost" code:kNonNet userInfo:nil];
            failure(err);
            [TNPromptBox showPromptBoxWithWords:kNetWorkErrorPromptText toView:nil];
        }
        return nil;
    }
    return [httpNormalManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *data in dataArray) {
            NSString *fileName = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
            fileName = [fileName stringByReplacingOccurrencesOfString:@"." withString:@""];
            fileName = [NSString stringWithFormat:@"%@.%@",fileName,fileNameSuffix];
            [formData appendPartWithFileData:data name:dataTypeName fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
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

@end
