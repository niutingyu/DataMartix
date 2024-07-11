//
//  ESBParmHeadTableCell.h
//  DataMatrix
//
//  Created by Andy on 2021/11/5.
//

#import "BaseTableViewCell.h"
#import "ESBMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBParmHeadTableCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indxLab;
@property (weak, nonatomic) IBOutlet UILabel *subProgressLab;
@property (weak, nonatomic) IBOutlet UILabel *parmLab;

@property (nonatomic,strong)ESBWFParmModel *model;

@end

NS_ASSUME_NONNULL_END
