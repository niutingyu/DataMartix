//
//  ScanditController.h
//  DataMatrix
//
//  Created by Andy on 2021/11/10.
//

#import "QRBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScanditController : QRBaseController

@property (nonatomic,copy)void(^toastResult)(NSString *result);
@end

NS_ASSUME_NONNULL_END
