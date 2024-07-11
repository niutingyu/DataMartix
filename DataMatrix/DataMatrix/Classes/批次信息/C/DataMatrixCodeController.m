//
//  DataMatrixCodeController.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/25.
//

#import "DataMatrixCodeController.h"
#import "GroupShadowTableView.h"
#import <AVFoundation/AVFoundation.h>
#import "ESBMainModel.h"
#import "ESBStepTableCell.h"
#import "ESBParmsTableCell.h"
#import "ESBParmFootView.h"
#import "RHScanViewController.h"
#import "ESBBaseInfoTableCell.h"
#import "ESBParmHeadTableCell.h"



#import "UIImage+ChangeColor.h"
#import "ESBCodeController.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Toast.h"
#import "LBXScanView.h"
#import "ScanditController.h"

#import "CustomComplistHistoryTableCell.h"
#import "CustomComplaintAlertView.h"
#import "CustomComplaintListModel.h"
@interface DataMatrixCodeController ()<DefaultScanDelegate>

@property (nonatomic,copy)NSString *resultStr;

/**
 基本信息
 */
@property (nonatomic,strong)NSMutableArray *basicList;

/**
 工站
 */
@property (nonatomic,strong)NSMutableArray *wipStepList;

/**
 参数信息
 */
@property (nonatomic,strong)NSMutableArray *parmList;


@property (nonatomic, strong) LBXScanViewStyle *style;
@end

@implementation DataMatrixCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"Pnl信息";
   
    
    /**扫码*/
    UIButton *but  =[UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:[UIImage imageNamed:@"iconfontscan"] forState:UIControlStateNormal];
    but.frame  =CGRectMake(0, 0, 60, 40);
    [but addTarget:self action:@selector(butMethod) forControlEvents:UIControlEventTouchUpInside];
    
  
    
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:but];
    
    self.navigationItem.rightBarButtonItem  =rightItem;
    

    
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator =NO;
    self.tableView.separatorStyle  =UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ESBStepTableCell class] forCellReuseIdentifier:@"stepCellId"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ESBParmsTableCell" bundle:nil] forCellReuseIdentifier:@"parmsCellId"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ESBBaseInfoTableCell" bundle:nil] forCellReuseIdentifier:@"infoCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ESBParmHeadTableCell" bundle:nil] forCellReuseIdentifier:@"parmHeadCellId"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomComplistHistoryTableCell" bundle:nil] forCellReuseIdentifier:@"cCellId"];
    if (self.resultStr.length >0) {
        KWeakSelf
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getdatasWithCode:weakSelf.resultStr];
        }];
    }
    
    self.tableView.mj_footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
                //加载最后一份数据后，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
          
        });
  //  [self getdatasWithCode:@"21038536e"];
  //  [self getWIPProgress];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.listDatasource.count ==0) {
        return 1;
    }else{
        return 4;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section  ==1){
        return 1;
    }else if (section ==2){
        ESBMainModel *model = [self.listDatasource firstObject];
        NSArray *parmList  =model.wfParameter;
        
        if (self.parmList.count ==0) {
            return parmList.count;
        }else{
            return self.parmList.count;
        }
    }
    else{
        return 1;
      
    }
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {

        ESBBaseInfoTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"infoCellId"];
        ESBMainModel *model  =[self.listDatasource firstObject];
        
        cell.model  =model.baseInfo;
        
        return cell;
        
    }else if (indexPath.section ==1){
        ESBStepTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"stepCellId"];
        ESBMainModel *model = [self.listDatasource firstObject];

        [cell configureCellWithModel:model.baseInfo stepList:self.wipStepList];
        //获取WIP进度
        
        cell.changeProgress = ^(NSInteger idx) {
         //   ESBAllStepModel *model  = weakSelf.wipStepList[idx-1];
           // [weakSelf getWIPProgressWithStepCode:model.code];
        };
        return cell;
    }else if (indexPath.section ==2){
        //流程参数
        if (indexPath.row ==0) {
            ESBParmHeadTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"parmHeadCellId"];
            ESBMainModel *model = [self.listDatasource firstObject];
            NSArray *parmList  =model.wfParameter;
            ESBWFParmModel *parmsModel;
            if (self.parmList.count ==0) {
                parmsModel = parmList[indexPath.row];
            }else{
                parmsModel  =self.parmList[indexPath.row];
            }
          
            parmsModel.number =[NSString stringWithFormat:@"%ld",indexPath.row +1];
            cell.model =parmsModel;
            return cell;
        }else{
            ESBParmsTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"parmsCellId"];
            ESBMainModel *model = [self.listDatasource firstObject];
            NSArray *parmList  =model.wfParameter;
            ESBWFParmModel *parmsModel;
            if (self.parmList.count ==0) {
                parmsModel = parmList[indexPath.row];
            }else{
                parmsModel  =self.parmList[indexPath.row];
            }
          
            parmsModel.number =[NSString stringWithFormat:@"%ld",indexPath.row +1];
            cell.model =parmsModel;
            return cell;
        }
    }
    else{
        CustomComplistHistoryTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cCellId"];
        
        KWeakSelf
        cell.viewCommandBlock = ^{
            
            [weakSelf getCustomComplaintHistoryList];
            
        };
        return  cell;
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 296.0f;
    }else if (indexPath.section ==1){
        if (self.wipStepList.count ==0) {
            return CGFLOAT_MIN;
        }else{
            return 100.0f;
        }
       
    }else if (indexPath.section ==2){
        ESBMainModel *model = [self.listDatasource firstObject];
        NSArray *parmList  =model.wfParameter;
        ESBWFParmModel *parmsModel = parmList[indexPath.row];
        if (indexPath.row ==0) {
            return parmsModel.rowHeight +36.0f;
        }else{
            return parmsModel.rowHeight;
        }
    }
    else{
       
        return 50.0f;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0f;
   
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section ==1) {
//        return 36.0f;
//    }else{
//        return CGFLOAT_MIN;
//    }
//}

//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section ==1) {
//        ESBParmFootView *footView  =[[ESBParmFootView alloc]init];
//
//        return footView;
//    }else{
//        return nil;
//    }
//}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSArray *titles  =@[@"基本信息",@"WIP进度",@""];
//    return titles[section];
//
//}



-(void)butMethod{


//    RHScanViewController *controller  =[[RHScanViewController alloc]init];
//    controller.isOpenInterestRect  =YES;
//    controller.isVideoZoom  =YES;
//    [self.navigationController pushViewController:controller animated:YES];
//    KWeakSelf
//    controller.scanSucessMethod = ^(NSString *scanResult) {
//
//        [weakSelf getdatasWithCode:scanResult];
//    };
    [self.listDatasource removeAllObjects];
    [self.wipStepList removeAllObjects];
    [self.tableView reloadData];
//
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:FALSE];
    HmsDefaultScanViewController *hmsDefaultScanViewController = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
    hmsDefaultScanViewController.defaultScanDelegate = self;


  //  [self.navigationController pushViewController:hmsDefaultScanViewController animated:YES];
    [self.view addSubview:hmsDefaultScanViewController.view];
    [self addChildViewController:hmsDefaultScanViewController];
    [self didMoveToParentViewController:hmsDefaultScanViewController];
    self.navigationController.navigationBarHidden = YES;
//    ESBCodeController *controller  =[[ESBCodeController alloc]init];
//    controller.style =[self scanStyle];
//    controller.orientation  =[self videoOrientation];
//    controller.isVideoZoom  =YES;
//    controller.cameraInvokeMsg =@"相机启动中";
//    [self.navigationController pushViewController:controller animated:YES];
//    KWeakSelf
//
//    controller.toastResult = ^(NSString * _Nonnull result) {
//        [weakSelf getdatasWithCode:result];
//    };
//    ScanditController *controller  =[[ScanditController alloc]init];
//    [self.navigationController  pushViewController:controller animated:YES];
//    KWeakSelf
//    controller.toastResult = ^(NSString * _Nonnull result) {
//        [weakSelf getdatasWithCode:result];
//    };
    
    UIButton *but  =[UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateSelected];
    but.imageView.contentMode  =UIViewContentModeScaleAspectFit;
  //  but.frame  =CGRectMake(kScreenWidth*0.5, kScreenHeight*0.7, 50, 40);
    [but addTarget:self action:@selector(butMethod:) forControlEvents:UIControlEventTouchUpInside];
    [hmsDefaultScanViewController.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_offset(-40);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(130);
    }];
    
  //  [self getdatasWithCode:@"2202834902"];
}

- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic{
    [self toastResult:resultDic];
}

- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
    NSDictionary *dic = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    [self toastResult:dic];
}
-(void)toastResult:(NSDictionary *)dic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController.view hideToastActivity];
    });
    
    if (dic == nil){
        [self.view makeToast:@"Scanning code not recognized" duration:1.0 position:@"CSToastPositionCenter" boolToast:YES];
        return;
    }
    NSString *string = [NSString stringWithFormat:@"%@", [dic objectForKey:@"text"]];
    if ([string length] == 0){
        [self.view makeToast:@"Scanning code not recognized" duration:1 position:@"CSToastPositionCenter" boolToast:YES];
        return;
    }
    
    NSString *toastString = [dic objectForKey:@"text"];
    self.resultStr  =toastString;
   
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getdatasWithCode:toastString];
    });
   
}


//获取扫码之后的批次信息
-(void)getdatasWithCode:(NSString*)code{
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    [parms setObject:code?:@"" forKey:@"pnlOrSet"];
    [parms setObject:@"SANDPNLORSET" forKey:@"actionType"];
    NSString *url  =@"esbrest/RestService/postrequest";
    [Units showLoadStatusWithString:Loading];
    KWeakSelf
    [NetWorkManage POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
        [Units hideView];
        NSDictionary * headerDict  = [responseObject objectForKey:@"Header"];
        NSString *resultStr  = [headerDict objectForKey:@"RESULT"];
        //[Units showStatusWithStutas:resultStr];
        if ([resultStr isEqualToString:ESB_Sucess]) {
            NSDictionary *bodyDict  = [responseObject objectForKey:@"Body"];
            NSArray *dataList  = [bodyDict objectForKey:@"data"];
            NSDictionary *dataDict  = [dataList firstObject];
            ESBMainModel *model  = [ESBMainModel mj_objectWithKeyValues:dataDict];
            ESBBaseInfoModel *infoModel  = model.baseInfo;
        
            //pnl赋值
            infoModel.pnlStr  =code;
            //设置进度
            [weakSelf setupProgressWithModel:model];
           
            [weakSelf.listDatasource removeAllObjects];
            [weakSelf.listDatasource addObject:model];
        }else{
            [Units showErrorStatusWithString:headerDict[@"RESULTMESSAGE"]];
        }
        debugLog(@"sucess %@",responseObject);
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } error:^(NSError * _Nonnull error) {
        debugLog(@" -- -%@",error);
        [Units hideView];
        [weakSelf.tableView.mj_header endRefreshing];
       
    }];
}

/**
 获取WIP进度
 */

-(void)getWIPProgressWithStepCode:(NSString*)stepCode{
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    [parms setObject:@"GETSTEPINFO" forKey:@"actionType"];
    [parms setObject:stepCode?:@"" forKey:@"stepCode"];
    [parms setObject:@"QTM04E28879-A0" forKey:@"partName"];
    NSString *url  =@"esbrest/RestService/postrequest";
    [Units showLoadStatusWithString:Loading];
    KWeakSelf
    [NetWorkManage POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
        [Units hideView];
        NSDictionary * headerDict  = [responseObject objectForKey:@"Header"];
        NSString *resultStr  = [headerDict objectForKey:@"RESULT"];
        if ([resultStr isEqualToString:ESB_Sucess]) {
            NSDictionary *bodyDict  = [responseObject objectForKey:@"Body"];
            NSArray *dataList  = [bodyDict objectForKey:@"data"];
            NSMutableArray *modelList  =[ESBWFParmModel mj_objectArrayWithKeyValuesArray:dataList];
         
            [weakSelf.parmList removeAllObjects];
            [weakSelf.parmList addObjectsFromArray:modelList];

        }
        [weakSelf.tableView reloadData];
        debugLog(@" sucesss %@",responseObject);
    } error:^(NSError * _Nonnull error) {
        [Units hideView];
        debugLog(@"error %@",error);
    }];
}

/**查看客诉历史信息*/

-(void)getCustomComplaintHistoryList{
    ESBMainModel *model =[self.listDatasource firstObject];
    ESBBaseInfoModel *infoModel  = model.baseInfo;
    NSRange range  = NSMakeRange(6, 5);
    NSString *pnNumber  = [infoModel.partName substringWithRange:range];
    NSMutableDictionary * parms  =[NSMutableDictionary dictionary];
    [parms setObject:pnNumber?:@"" forKey:@"pnNumber"];
    NSString *url =@"rt/customercomplaintssubject/getCcsHistoryByPnNumber";
    
    
   
    [NetWorkManage ErpPostWithUrl:[url getWholeUrl] parms:parms sucess:^(id  _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSString *jsonStr  = [responseObject objectForKey:@"data"];
            NSArray *jsonList  = [Units jsonToArray:jsonStr];
            NSMutableArray *modelList  = [CustomComplaintListModel mj_objectArrayWithKeyValuesArray:jsonList];
          
            [CustomComplaintAlertView showassetAlertViewWithHistoryList:modelList];
         
        }
       
    } error:^(NSError * _Nonnull error) {
        debugLog(@"error%@",error);
    }];
}

//进度
-(void)setupProgressWithModel:(ESBMainModel*)model{
    ESBBaseInfoModel *infoModel  =model.baseInfo;
    //取出当前的进度
    int  currentStep = [infoModel.stepSeqNo intValue]-2;
    debugLog(@"currentStep %d %ld",currentStep,model.allStep.count);
    //全部进度
    NSArray *allStepList  = model.allStep;
    //NSMutableArray *displayStepList  =[NSMutableArray array];
    [self.wipStepList removeAllObjects];
    //当前工站为第一个 并且后面有3个工站
    if (currentStep ==0 && currentStep <=allStepList.count-3) {
        [self.wipStepList addObject:[allStepList firstObject]];
        [self.wipStepList addObject:allStepList[1]];
        [self.wipStepList addObject:allStepList[2]];
        [self.wipStepList addObject:allStepList[3]];
    }else if (currentStep >=1 &&currentStep <allStepList.count -2){
        [self.wipStepList addObject:allStepList[currentStep-1]];
        [self.wipStepList addObject:allStepList[currentStep]];
        [self.wipStepList addObject:allStepList[currentStep+1]];
        [self.wipStepList addObject:allStepList[currentStep+2]];
    }else if (currentStep >=2 &&currentStep<allStepList.count -1){
        [self.wipStepList addObject:allStepList[currentStep-2]];
        [self.wipStepList addObject:allStepList[currentStep-1]];
        [self.wipStepList addObject:allStepList[currentStep]];
        [self.wipStepList addObject:allStepList[currentStep+1]];
    }else if (currentStep >=3 &&currentStep<=allStepList.count){
        [self.wipStepList addObject:allStepList[currentStep-3]];
        [self.wipStepList addObject:allStepList[currentStep-2]];
        [self.wipStepList addObject:allStepList[currentStep-1]];
        [self.wipStepList addObject:allStepList[currentStep]];
    }

    debugLog(@" -- -wip %@",self.wipStepList);
    [self.tableView reloadData];
    
}

-(NSMutableArray*)basicList{
    if (!_basicList) {
        _basicList  =[NSMutableArray array];
    }return _basicList;
}

-(NSMutableArray*)wipStepList{
    if (!_wipStepList) {
        _wipStepList  =[NSMutableArray array];
    }return _wipStepList;
}

-(NSMutableArray*)parmList{
    if (!_parmList) {
        _parmList =[NSMutableArray array];
    }return _parmList;
}

-(void)butMethod:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
}
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
-(LBXScanViewStyle*)scanStyle{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    [self modifyLandScape:style];
    
    return style;
    
}

- (void)modifyLandScape:(LBXScanViewStyle*)style
{
    if ([self isLandScape]) {
          
          style.centerUpOffset = 20;
          
          CGFloat w = [UIScreen mainScreen].bounds.size.width;
          CGFloat h = [UIScreen mainScreen].bounds.size.height;
          
          CGFloat max = MAX(w, h);
          
          CGFloat min = MIN(w, h);
          
          CGFloat scanRetangeH = min / 3;
          
          style.xScanRetangleOffset = max / 2 - scanRetangeH / 2;
      }
      else
      {
          style.centerUpOffset = 40;
          style.xScanRetangleOffset = 60;
      }
}
- (BOOL)isLandScape
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

    BOOL landScape = NO;
    
    
    switch (orientation) {
        case UIDeviceOrientationPortrait: {
            landScape = NO;
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            landScape = YES;
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            
            landScape = YES;
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown: {
            
            landScape = NO;
        }
            break;
        default:
            break;
    }
    
    return landScape;
    
}

- (AVCaptureVideoOrientation)videoOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    
    switch (orientation) {
        case UIDeviceOrientationPortrait: {
            return AVCaptureVideoOrientationPortrait;
        }
            break;
        case UIDeviceOrientationLandscapeRight : {
            return AVCaptureVideoOrientationLandscapeLeft;
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            return AVCaptureVideoOrientationLandscapeRight;
            
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown: {
            return AVCaptureVideoOrientationPortraitUpsideDown;
            
        }
            break;
        default:
            return AVCaptureVideoOrientationPortrait;
            break;
    }
    
    return AVCaptureVideoOrientationPortrait;
}
@end
