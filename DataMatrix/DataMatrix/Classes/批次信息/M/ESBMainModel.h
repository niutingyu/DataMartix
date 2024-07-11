//
//  ESBMainModel.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import <Foundation/Foundation.h>
#import "ESBAllStepModel.h"
#import "ESBBaseInfoModel.h"
#import "ESBWFParmModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBMainModel : NSObject
//WIP进度
@property (nonatomic,strong)NSArray<ESBAllStepModel*> *allStep;

//基本信息
//@property (nonatomic,strong)NSDictionary<ESBBaseInfoModel*> *baseInfo;
@property (nonatomic,strong)ESBBaseInfoModel *baseInfo;
//流程参数
@property (nonatomic,strong)NSArray<ESBWFParmModel*> *wfParameter;

@end

NS_ASSUME_NONNULL_END
