//
//  ESBCodeController.h
//  DataMatrix
//
//  Created by Andy on 2021/11/5.
//

#import "QRBaseController.h"
#import "LBXScanView.h"
#import "LBXScanNativeViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ESBCodeController : LBXScanNativeViewController


/*
@brief  扫码区域上方提示文字
*/
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

//@property (nonatomic,copy)void(^toastResult)(NSString *result);

@end

NS_ASSUME_NONNULL_END
