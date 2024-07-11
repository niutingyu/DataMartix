//
//  DataMatrix.header.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/25.
//
#import "NetWorkManage.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "NSString+Category.h"
#import "Units.h"
#import "Masonry.h"
#ifndef DataMatrix_header_h
#define DataMatrix_header_h
#define kScreenWidth    CGRectGetWidth([UIScreen mainScreen].bounds)

#define kScreenHeight   CGRectGetHeight([UIScreen mainScreen].bounds)

#define RGBA(R,G,B,A) [UIColor colorWithRed:(R/255.0) green:(G/255.0) blue:(B/255.0) alpha:A]


#define KWeakSelf __weak typeof(self) weakSelf = self;

#define Loading @"正在加载..."
#define ESB_Sucess @"SUCCESS"

#ifdef DEBUG
#define debugLog(FORMAT, ...)  fprintf(stderr,"%s:%d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define debugLog(FORMAT, ...) nil

#endif

#endif /* DataMatrix_header_h */
