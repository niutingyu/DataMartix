//
//  NSString+Category.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSString *)getWholeUrl{
    
    return [NSString stringWithFormat:@"%@%@",NetworkServerAddress,self];
}
@end
