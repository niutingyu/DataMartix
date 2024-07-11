//
//  Units.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface Units : NSObject

+(NSDictionary*)jsonToDictionary:(NSString*)json;

+(NSArray*)jsonToArray:(NSString*)json;

+(NSString*)dictionaryToJson:(NSDictionary*)dictionry;

+(NSString*)arrayToJson:(NSArray*)array;

+(void)showStatusWithStutas:(NSString*)status;

+(void)showLoadStatusWithString:(NSString*)string;


+(void)showErrorStatusWithString:(NSString*)string;

+(void)hideView;

+(CGFloat)calculateRowHeight:(NSString*)string width:(CGFloat)width;

+ (NSString *)timeWithTime:(NSString *)time beforeFormat:(NSString *)before andAfterFormat:(NSString *)after;
@end

NS_ASSUME_NONNULL_END
