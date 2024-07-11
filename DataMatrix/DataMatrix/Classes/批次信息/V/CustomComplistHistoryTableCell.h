//
//  CustomComplistHistoryTableCell.h
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomComplistHistoryTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *viewButton;

@property (nonatomic,copy)void(^viewCommandBlock)(void);

@end

NS_ASSUME_NONNULL_END
