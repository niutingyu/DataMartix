//
//  ESBParmFootView.m
//  DataMatrixCode
//
//  Created by Andy on 2021/11/1.
//

#import "ESBParmFootView.h"

@implementation ESBParmFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self setupUI];
    }return self;
}

-(void)setupUI{
    
    //最上面分割线
    UIView *topLine  =[[UIView alloc]init];
    topLine.backgroundColor  =RGBA(94, 149, 216, 1);
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    //下面的分割线
    UIView *line1 =[[UIView alloc]init];
    line1.backgroundColor =RGBA(94, 149, 216, 1);
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line2 =[[UIView alloc]init];
    line2.backgroundColor  =RGBA(94, 149, 216, 1);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLine.mas_bottom).mas_offset(0);
        make.left.mas_offset(0);
        make.bottom.mas_equalTo(line1.mas_top).mas_offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UIView *line3 =[[UIView alloc]init];
    line3.backgroundColor =RGBA(94, 149, 216, 1);
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2.mas_right).mas_offset(40);
        make.top.mas_equalTo(topLine.mas_bottom).mas_offset(0);
        make.bottom.mas_equalTo(line1.mas_top).mas_offset(0);
        make.width.mas_equalTo(1);
    }];
    
    //序号
    UILabel *numberLab  =[[UILabel alloc]init];
    numberLab.textAlignment =NSTextAlignmentCenter;
    numberLab.text =@"序号";
    numberLab.font =[UIFont systemFontOfSize:15];
    [self addSubview:numberLab];
    [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(line3.mas_left).mas_offset(-1);
    }];
    
    //自工序
    UIView *line4 =[[UIView alloc]init];
    line4.backgroundColor =RGBA(94, 149, 216, 1);
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLine.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(line3.mas_left).mas_offset(111);
        make.bottom.mas_equalTo(line1.mas_top).mas_offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *subParmLab  =[[UILabel alloc]init];
    subParmLab.textAlignment  =NSTextAlignmentCenter;
    subParmLab.text =@"子工序";
    subParmLab.font  =[UIFont systemFontOfSize:15];
    [self addSubview:subParmLab];
    [subParmLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line3.mas_right).mas_offset(2);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(line4.mas_left).mas_offset(-2);
    }];
    
    //流程参数
    UIView *line5  =[[UIView alloc]init];
    line5.backgroundColor =RGBA(94, 149, 216, 1);
    [self addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.top.mas_equalTo(topLine.mas_bottom).mas_offset(0);
        make.bottom.mas_equalTo(line1.mas_top).mas_offset(0);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *parmLab  =[[UILabel alloc]init];
    parmLab.font  =[UIFont systemFontOfSize:15];
    parmLab.textAlignment =NSTextAlignmentCenter;
    parmLab.text =@"流程参数";
    [self addSubview:parmLab];
    [parmLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line4.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(line5.mas_left).mas_offset(-8);
        
    }];
    
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x +=3;
    frame.size.width -=6;
    [super setFrame:frame];
}
@end
