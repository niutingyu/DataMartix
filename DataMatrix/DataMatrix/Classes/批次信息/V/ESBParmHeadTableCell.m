//
//  ESBParmHeadTableCell.m
//  DataMatrix
//
//  Created by Andy on 2021/11/5.
//

#import "ESBParmHeadTableCell.h"

@implementation ESBParmHeadTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.contentView.backgroundColor = RGBA(94, 149, 216, 1);
    self.layer.cornerRadius  =1;
    self.clipsToBounds  =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(ESBWFParmModel *)model{
    _model  =model;
    self.indxLab.text = model.number;
    self.subProgressLab.text  =model.subProcedureName;
    self.parmLab.text =model.totalParmString;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x+=5;
    frame.size.width -=10;
//    self.layer.borderWidth = 1.0f;
//    self.layer.borderColor = RGBA(94, 149, 216, 1).CGColor;
    
    [super setFrame:frame];
}
@end
