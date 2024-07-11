//
//  ESBWFParmModel.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESBWFParmModel : NSObject

//@property (nonatomic,copy)NSString *param;
//
//@property (nonatomic,copy)NSString *subProcedureCode;
//
//@property (nonatomic,copy)NSString *subProcedureName;

@property (nonatomic,strong)NSArray *list;

@property (nonatomic,copy)NSString *subProcedureCode;

@property (nonatomic,copy)NSString *subProcedureName;

@property (nonatomic,copy)NSString *totalParmString;

@property (nonatomic,copy)NSString *number;

@property (nonatomic,assign)CGFloat rowHeight;

@end




NS_ASSUME_NONNULL_END
