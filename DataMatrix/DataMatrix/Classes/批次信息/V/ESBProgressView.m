//
//  ESBProgressView.m
//  DataMatrix
//
//  Created by Andy on 2021/11/9.
//

#import "ESBProgressView.h"


#define TINTCOLOR [UIColor colorWithRed:35/255.f green:135/255.f blue:255/255.f alpha:1]
#define NOPASSCOLOR [UIColor colorWithRed:138/255.f green:207/255.f blue:227/255.f alpha:1]
@interface ESBProgressView ()

@property (nonatomic, strong)UIView *lineUndo;
@property (nonatomic, strong)UIView *lineDone;

@property (nonatomic, retain)NSMutableArray *cricleMarks;
@property (nonatomic, retain)NSMutableArray *titleLabels;

@property (nonatomic, strong)UILabel *lblIndicator;

@end
@implementation ESBProgressView

- (instancetype)initWithFrame:(CGRect)frame Titles:(nonnull NSArray *)titles
{
    if ([super initWithFrame:frame])
    {
        //移除之前的视图,不移除会重叠
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
        
        _stepIndex = 2;
        
        _titles = titles;
        
        _lineUndo = [[UIView alloc]init];
        _lineUndo.backgroundColor = NOPASSCOLOR;
        [self addSubview:_lineUndo];
        
        _lineDone = [[UIView alloc]init];
        _lineDone.backgroundColor = TINTCOLOR;
        [self addSubview:_lineDone];
        
        for (NSString *title in _titles)
        {
            UILabel *lbl = [[UILabel alloc]init];
            lbl.text = title;
            lbl.textColor = [UIColor lightGrayColor];
            lbl.font = [UIFont systemFontOfSize:14];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.numberOfLines  =0;
            [self addSubview:lbl];
            [self.titleLabels addObject:lbl];
            
            UIView *cricle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
            cricle.backgroundColor = [UIColor lightGrayColor];
            cricle.layer.cornerRadius = 16.f / 2;
            [self addSubview:cricle];
            [self.cricleMarks addObject:cricle];
        }
        //当前节点
        _lblIndicator = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        _lblIndicator.textAlignment = NSTextAlignmentCenter;
        _lblIndicator.textColor = TINTCOLOR;
        _lblIndicator.backgroundColor = TINTCOLOR;
        _lblIndicator.layer.cornerRadius = 25.f / 2;
        _lblIndicator.layer.borderColor = [TINTCOLOR CGColor];
        _lblIndicator.layer.borderWidth = 1;
        _lblIndicator.layer.masksToBounds = YES;
        [self addSubview:_lblIndicator];
    }
    return self;
}

#pragma mark - method

- (void)layoutSubviews
{
    
    NSInteger perWidth = self.frame.size.width / self.titles.count;
    
    _lineUndo.frame = CGRectMake(0, 0, self.frame.size.width - perWidth, 3);
    _lineUndo.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4);
    
    CGFloat startX = _lineUndo.frame.origin.x;
    
    for (int i = 0; i < _titles.count; i++)
    {
        UIView *cricle = [_cricleMarks objectAtIndex:i];
        if (cricle != nil)
        {
            cricle.center = CGPointMake(i * perWidth + startX, _lineUndo.center.y);
        }
        
        UILabel *lbl = [_titleLabels objectAtIndex:i];
        if (lbl != nil)
        {
            lbl.frame = CGRectMake(perWidth * i, self.frame.size.height / 2, self.frame.size.width / _titles.count, self.frame.size.height / 2);
        }
    }
    
    self.stepIndex = _stepIndex;
}

- (NSMutableArray *)cricleMarks
{
    if (_cricleMarks == nil)
    {
        _cricleMarks = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _cricleMarks;
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil)
    {
        _titleLabels = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _titleLabels;
}

#pragma mark - public method

- (void)setStepIndex:(NSInteger)stepIndex
{
    if (stepIndex >= 0 && stepIndex < self.titles.count)
    {
        _stepIndex = stepIndex;
        
        CGFloat perWidth = self.frame.size.width / _titles.count;
        
       // _lblIndicator.text = [NSString stringWithFormat:@"%d", _stepIndex + 1];
        _lblIndicator.center = ((UIView *)[_cricleMarks objectAtIndex:_stepIndex]).center;
        
        _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _stepIndex, _lineUndo.frame.size.height);
        
        for (int i = 0; i < _titles.count; i++)
        {
            UIView *cricle = [_cricleMarks objectAtIndex:i];
            if (cricle != nil)
            {
                if (i <= _stepIndex)
                {
                    cricle.backgroundColor = TINTCOLOR;
                }
                else
                {
                    cricle.backgroundColor = NOPASSCOLOR;
                }
            }
            
            UILabel *lbl = [_titleLabels objectAtIndex:i];
            if (lbl != nil)
            {
                if (i <= stepIndex)
                {
                    lbl.textColor = TINTCOLOR;
                }
                else
                {
                    lbl.textColor = NOPASSCOLOR;
                }
            }
        }
    }
}

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation
{
    if (stepIndex >= 0 && stepIndex < self.titles.count)
    {
        if (animation)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.stepIndex = stepIndex;
            }];
        }
        else
        {
            self.stepIndex = stepIndex;
        }
    }
}


@end
