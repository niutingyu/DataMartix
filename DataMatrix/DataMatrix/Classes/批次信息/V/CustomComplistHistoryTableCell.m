//
//  CustomComplistHistoryTableCell.m
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "CustomComplistHistoryTableCell.h"

@implementation CustomComplistHistoryTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewButton.layer.cornerRadius =3;
    self.viewButton.clipsToBounds =YES;
    [self.viewButton addTarget:self action:@selector(butCommand) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)butCommand{
    if (self.viewCommandBlock) {
        self.viewCommandBlock();
    }
}

@end
