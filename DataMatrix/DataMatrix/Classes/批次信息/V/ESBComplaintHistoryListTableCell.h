//
//  ESBComplaintHistoryListTableCell.h
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "BaseTableViewCell.h"
#import "CustomComplaintListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBComplaintHistoryListTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *verLab;
@property (weak, nonatomic) IBOutlet UILabel *processLab;
@property (weak, nonatomic) IBOutlet UILabel *problemLab;

@property (nonatomic,strong)CustomComplaintListModel *model;
@end

NS_ASSUME_NONNULL_END
