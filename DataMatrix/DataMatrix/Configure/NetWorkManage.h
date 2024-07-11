//
//  NetWorkManage.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^SucceedBlock)(id responseObject);

typedef void(^ErrorBlock)(NSError *error);

@interface NetWorkManage : NSObject

+ (void)POST:(NSString *)url param:(NSDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback;

+(void)ErpPostWithUrl:(NSString*)url  parms:(NSMutableDictionary*)parms  sucess:(SucceedBlock)sucessCallBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END
