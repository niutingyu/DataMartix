//
//  ESBProgressView.h
//  DataMatrix
//
//  Created by Andy on 2021/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESBProgressView : UIView

@property (nonatomic, retain)NSArray * _Nonnull titles;

@property (nonatomic, assign)NSInteger stepIndex;

- (instancetype _Nonnull )initWithFrame:(CGRect)frame Titles:(nonnull NSArray *)titles;

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
