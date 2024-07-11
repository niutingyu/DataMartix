//
//  ESBBaseInfoTableCell.h
//  DataMatrixCode
//
//  Created by Andy on 2021/11/4.
//

#import "BaseTableViewCell.h"
#import "ESBMainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBBaseInfoTableCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *pnlLab;

@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *styleLab;
@property (weak, nonatomic) IBOutlet UILabel *partLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *lotLab;

@property (nonatomic,strong)ESBBaseInfoModel *model;



@end

NS_ASSUME_NONNULL_END
