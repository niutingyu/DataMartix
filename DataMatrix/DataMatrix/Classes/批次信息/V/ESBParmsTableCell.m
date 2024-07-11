//
//  ESBParmsTableCell.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "ESBParmsTableCell.h"




@interface ESBParmsTableCell ()



@end
@implementation ESBParmsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // self.backgroundColor  =[UIColor lightGrayColor];
  self.contentView.backgroundColor = RGBA(94, 149, 216, 1);
    self.layer.cornerRadius  =1;
    self.clipsToBounds  =YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ESBWFParmModel *)model{
    _model  =model;
    self.numberLab.text = model.number;
    self.subNameLab.text  =model.subProcedureName;
    self.parmsLab.text =model.totalParmString;
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x +=5;
    frame.size.width -=10;
 //   self.layer.borderWidth = 1.0f;
  //  self.layer.borderColor = RGBA(94, 149, 216, 1).CGColor;
   // self.layer.masksToBounds = YES;
   
    [super setFrame:frame];
}
@end
