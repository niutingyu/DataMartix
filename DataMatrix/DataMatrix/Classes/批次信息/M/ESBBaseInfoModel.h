//
//  ESBBaseInfoModel.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESBBaseInfoModel : NSObject
//客户代码
@property (nonatomic,copy)NSString *customerCode;

//lotID
@property (nonatomic,copy)NSString *lotId;

//PNL数量
@property (nonatomic,copy)NSString *panelQty;

//产品型号
@property (nonatomic,copy)NSString *partName;

//回复交期
@property (nonatomic,copy)NSString *requireDate;

@property (nonatomic,copy)NSString *stepCode;

@property (nonatomic,copy)NSString *stepName;

//进度
@property (nonatomic,copy)NSString *stepSeqNo;

/**
 仓位号
 */
@property (nonatomic,copy)NSString *locatorId;

@property (nonatomic,copy)NSString *dateStr;

/**
 PNl
 */
@property (nonatomic,copy)NSString *pnlStr;

@end

NS_ASSUME_NONNULL_END
