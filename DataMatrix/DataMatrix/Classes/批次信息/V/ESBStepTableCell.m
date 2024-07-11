//
//  ESBStepTableCell.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "ESBStepTableCell.h"
#import "RTProgressView.h"
#import "ESBProgressView.h"

@interface ESBStepTableCell ()

@property (nonatomic,strong)ESBProgressView *progressView;

@property (nonatomic,strong)ESBBaseInfoModel *infoModel;

@end
@implementation ESBStepTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

//        self.progressView.frame  = CGRectMake(0, self.contentView.center.y, kScreenWidth-8, 49);
//
//        [self.contentView addSubview:self.progressView];
        
      
    }
    return self;
}



-(void)configureCellWithModel:(ESBBaseInfoModel*)model stepList:(NSMutableArray*)stepList{
  
    _infoModel  =model;
    NSMutableArray *titles  =[NSMutableArray array];
   
    [titles removeAllObjects];
    
    for (ESBAllStepModel *model in stepList) {
        if (![titles containsObject:model.name]) {
            [titles addObject:model.name];
        }
        
    }
    
    if (titles.count >0) {
        [_progressView removeFromSuperview];
        NSInteger index  = [titles indexOfObject:model.stepName];
        _progressView =[[ESBProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) Titles:titles];
        _progressView.stepIndex  =index;
        [self.contentView addSubview:_progressView];
//        [self.progressView setWarningArray:@[model.stepName]];
//        [self.progressView showProgressViewWithTitleArray:titles detailArray:detailList isHorizontal:YES style:kProgressStyleNormal];
    }
    
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x +=5;
   
    frame.size.width -=10;
    self.layer.cornerRadius = 3.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = RGBA(94, 149, 216, 1).CGColor;
    self.layer.masksToBounds = YES;
    [super setFrame:frame];
}



@end
