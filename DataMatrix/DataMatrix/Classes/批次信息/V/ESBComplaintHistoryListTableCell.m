//
//  ESBComplaintHistoryListTableCell.m
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "ESBComplaintHistoryListTableCell.h"

@implementation ESBComplaintHistoryListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CustomComplaintListModel *)model{
    self.timeLab.text = [Units timeWithTime:model.ComplaintTime?:@"" beforeFormat:@"yyyy-MM-dd HH:mm:ss" andAfterFormat:@"yyyy-MM-dd"];
    self.verLab.text =model.Ver?:@"";
    self.processLab.text =model.ProductionProcess?:@"";
    self.problemLab.text =model.CauseDescription?:@"";
}



@end
