//
//  CustomComplaintListModel.h
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomComplaintListModel : NSObject

@property (nonatomic,copy)NSString *ProductionProcess;

@property (nonatomic,copy)NSString *ComplaintTime;

@property (nonatomic,copy)NSString *Ver;

@property (nonatomic,copy)NSString *CauseDescription;

@property (nonatomic,assign)CGFloat rowHeigh;

@end

NS_ASSUME_NONNULL_END
