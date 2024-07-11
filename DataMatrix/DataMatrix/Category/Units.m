//
//  Units.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import "Units.h"

@implementation Units

//json字符串转化字典
+(NSDictionary*)jsonToDictionary:(NSString*)json{
    if (json == nil){
        return nil;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    return dic;
}

//json字符串转化数组
+(NSArray*)jsonToArray:(NSString*)json{
    if (json == nil){
        return nil;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return array;
}

//字典转化json字符串
+(NSString*)dictionaryToJson:(NSDictionary*)dictionry{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionry options:0 error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//数组转化json字符串
+(NSString*)arrayToJson:(NSArray*)array{
    //(1).先讲数组转化成NSData数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    NSString *resultString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resultString;
}

+(void)showStatusWithStutas:(NSString*)status{
    [self hideView];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:status];
    [SVProgressHUD dismissWithDelay:2];
}

+(void)showLoadStatusWithString:(NSString*)string{
    // 如果当前视图还有其他提示框，就dismiss
    [self hideView];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    // 加载中的提示框一般不要不自动dismiss，比如在网络请求，要在网络请求成功后调用 hideLoadingHUD 方法即可
    if (string) {
        [SVProgressHUD showWithStatus:string];
    }else{
        [SVProgressHUD show];
    }
}

+(void)showErrorStatusWithString:(NSString*)string{
    
    [SVProgressHUD showInfoWithStatus:string];
    [SVProgressHUD dismissWithDelay:1.0];
}
+(void)hideView{
    [SVProgressHUD dismiss];
    //[HttpTool CancelRequest];
}

+ (NSString *)timeWithTime:(NSString *)time beforeFormat:(NSString *)before andAfterFormat:(NSString *)after {
    NSDate *date = [self dataFromString:time withFormat:before];
    NSString *result = [self timeWithDate:date andFormat:after];
    return result;
}

+ (NSDate *)dataFromString:(NSString *)time withFormat:(NSString *)format {
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:time];
    
    return date;
}

+ (NSString *)timeWithDate:(NSDate *)date andFormat:(NSString *)format {
    if (format == nil) {
        format = @"HH:mm";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}

//根据文字计算高度
+(CGFloat)calculateRowHeight:(NSString*)string width:(CGFloat)width{
    NSDictionary * dic =@{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect  =[string?:@"" boundingRectWithSize:CGSizeMake(width-10, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.height;
}
@end
