//
//  BaseTableViewCell.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor =[UIColor whiteColor];
    self.selectionStyle  =UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor =[UIColor whiteColor];
        self.selectionStyle  =UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
