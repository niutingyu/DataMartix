//
//  ESBParmsTableCell.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "BaseTableViewCell.h"
#import "ESBMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBParmsTableCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *subNameLab;
@property (weak, nonatomic) IBOutlet UILabel *parmsLab;
@property (nonatomic,strong)ESBWFParmModel *model;

@end

NS_ASSUME_NONNULL_END
