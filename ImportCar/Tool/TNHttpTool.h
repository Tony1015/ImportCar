//
//  TNHttpTool.h
//  BaseProject
//
//  Created by Tony on 2017/8/9.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBaseResponse.h"

//依赖AFNetworking

FOUNDATION_EXPORT NSString * const TNNetworkReachabilityDidChangeNotification;

typedef NS_ENUM(NSInteger ,TNNetWorkState) {
    TNNetWorkStateUnknown            = -1,
    TNNetWorkStateNotReachable       = 0,
    TNNetWorkStateReachableViaWWAN   = 1,
    TNNetWorkStateReachableViaWifi   = 2,
};


typedef void (^TNSUCCESS)(id);
typedef void (^TNFAILURE)(NSError *);


@interface TNHttpTool : NSObject



+(TNNetWorkState)currentNetWorkStates;


/**
 *  @brief 设置请求头
 *
 *  @param fileds 字段
 */
+ (void)setHttpRequestHeaderFields:(NSDictionary *)fileds security:(BOOL)security;


/**
 *  @brief 清除自定义header
 */
+ (void)clearCustomRequestHeaderWithKeys:(NSArray *)keys security:(BOOL)security;



/********网络请求类******/
/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (NSURLSessionDataTask *)get:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(id json))success
                      failure:(void (^)(NSError *error))failure;
/**
 *  get请求--带cookie
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
                      failure:(void (^)(NSError *error))failure;
/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (NSURLSessionDataTask *)post:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id json))success
                       failure:(void (^)(NSError *error))failure;


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
                       failure:(void (^)(NSError *error))failure;




//上传文件or上传图片
+ (NSURLSessionDataTask *)uploadDataWithUrl:(NSString *)url
                                     params:(NSDictionary *)params
                                  dataArray:(NSArray *)dataArray
                               dataTypeName:(NSString *)dataTypeName
                             fileNameSuffix:(NSString *)fileNameSuffix
                                   mimeType:(NSString *)mimeType
                                   progress:(void (^) (NSProgress *))progress
                                    success:(void (^)(id))success
                                    failure:(void (^)(NSError *))failure;

@end
