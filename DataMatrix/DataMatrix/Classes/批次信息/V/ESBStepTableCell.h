//
//  ESBStepTableCell.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "BaseTableViewCell.h"

#import "ESBMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBStepTableCell : BaseTableViewCell

-(void)configureCellWithModel:(ESBBaseInfoModel*)model stepList:(NSMutableArray*)stepList;

@property (nonatomic,copy)void(^changeProgress)(NSInteger idx);
@end

NS_ASSUME_NONNULL_END
