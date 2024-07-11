//
//  ESBBaseInfoTableCell.m
//  DataMatrixCode
//
//  Created by Andy on 2021/11/4.
//

#import "ESBBaseInfoTableCell.h"

@implementation ESBBaseInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor lightGrayColor];
//    self.layer.cornerRadius  =2;
//    self.clipsToBounds  =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ESBBaseInfoModel *)model{
    _model  =model;
    self.pnlLab.text =model.pnlStr?:@"";
    self.codeLab.text =model.customerCode?:@"";
    self.styleLab.text =model.partName?:@"";
    self.partLab.text =model.lotId?:@"";
    self.countLab.text  =model.panelQty?:@"";
    self.dateLab.text =model.dateStr?:@"";
    self.lotLab.text  =model.locatorId?:@"";
    
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x +=5;
    frame.size.width -=10;
//    static CGFloat margin = 15;
//    frame.size.height -=margin;
//    //阴影偏移效果 - wsx注释
//    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(4, 4);
//    self.layer.shadowOpacity = 0.8f;
        
    self.layer.cornerRadius = 3.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = RGBA(94, 149, 216, 1).CGColor;
    self.layer.masksToBounds = YES;
    [super setFrame:frame];
}
@end
