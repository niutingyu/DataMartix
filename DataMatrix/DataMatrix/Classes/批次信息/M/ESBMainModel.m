//
//  ESBMainModel.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "ESBMainModel.h"

@implementation ESBMainModel

+(NSDictionary*)mj_objectClassInArray{
    return @{@"allStep":[ESBAllStepModel class],@"baseInfo":[ESBBaseInfoModel class],@"wfParameter":[ESBWFParmModel class]};
}
@end
