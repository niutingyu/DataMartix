//
//  ESBBaseInfoModel.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "ESBBaseInfoModel.h"

@implementation ESBBaseInfoModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    //时间戳转化为时间
    NSTimeInterval interval    =[_requireDate doubleValue] / 1000.0;

        NSDate *date          = [NSDate dateWithTimeIntervalSince1970:interval];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        [formatter setDateFormat:@"yyyy-MM-dd"];

        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];

        NSString *dateString      = [formatter stringFromDate: date];
        _dateStr  =dateString;

        
}


@end
