//
//  ESBAllStepModel.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESBAllStepModel : NSObject
//代码
@property (nonatomic,copy)NSString *code;

//节点名称
@property (nonatomic,copy)NSString *name;

//进度
@property (nonatomic,copy)NSString *seqNo;

@end

NS_ASSUME_NONNULL_END
