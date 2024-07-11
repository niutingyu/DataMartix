//
//  NetWorkManage.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import "NetWorkManage.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NetWorkManage


+ (void)POST:(NSString *)url param:(NSMutableDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback;{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
   [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    // 设置请求时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 200.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    NSMutableDictionary *parmetersAll = [NSMutableDictionary dictionary];
    [parmetersAll setObject:@"SLPDASender" forKey:@"senderId"];
    

    //head 参数
    NSDictionary *headDic  =@{@"MESSAGENAME":@"SANDCODEAPP",@"ORGNAME":@"GZSL02",@"ORGRRN":@"378341",@"TRANSACTIONID":@"56485346",@"USERNAME":@"PDA"};
    NSMutableDictionary *headParms  =[NSMutableDictionary dictionary];
    [headParms setObject:headDic forKey:@"Header"];

    //body参数
    NSMutableDictionary *bodyParms  =[NSMutableDictionary dictionary];
   // [param setObject:@"SANDPNLORSET" forKey:@"actionType"];
    [bodyParms setObject:param forKey:@"Body"];

    NSMutableDictionary *requestBaseParms =[[NSMutableDictionary alloc]initWithDictionary:headParms];
    [requestBaseParms addEntriesFromDictionary:bodyParms];
    NSDictionary *valueRequestDic  =@{@"Request":requestBaseParms};
    [parmetersAll setObject:[Units dictionaryToJson:valueRequestDic] forKey:@"requestMessage"];

    debugLog(@"parmsAll %@ url %@",parmetersAll,url);
    debugLog(@"head %@",manager.requestSerializer.HTTPRequestHeaders);
   
    [manager POST:url parameters:parmetersAll headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successCallback) {
            successCallback(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [Units showErrorStatusWithString:@"获取数据失败,请联系IT"];
            if (errorCallback) {
                errorCallback(error);
            }
        }
    }];
    
}

+(void)ErpPostWithUrl:(NSString*)url  parms:(NSMutableDictionary*)parms  sucess:(SucceedBlock)sucessCallBlock error:(ErrorBlock)errorBlock{
    AFHTTPSessionManager  *manager  =[AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    NSString *signStr = [NSString stringWithFormat:@"slclient%@slclient_canyou",timeString];
       
       signStr = [[[NetWorkManage alloc]init] MD5:signStr];
       
       signStr = [signStr stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    
    NSDictionary * baseDic  =@{@"appkey":@"slclient",
                               @"time":timeString,
                               @"loginuser":@"admin",
                              
                               @"sign":signStr,
    };
   
    NSMutableDictionary *parmetersAll = [[NSMutableDictionary alloc]initWithDictionary:baseDic];
    [parmetersAll addEntriesFromDictionary:parms];
    debugLog(@" - %@  %@",parmetersAll,url);
    
    [manager POST:url parameters:parmetersAll headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucessCallBlock) {
            sucessCallBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error.localizedDescription);
        }
    }];
    
    
}


- (NSString *)MD5:(NSString *)mdStr
{
    const char *original_str = [mdStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
@end
