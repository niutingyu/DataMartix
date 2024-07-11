//
//  ScanditWebController.m
//  DataMatrix
//
//  Created by Andy on 2022/10/23.
//

#import "ScanditWebController.h"
#import <WebKit/WebKit.h>
#import <ScanKitFrameWork/ScanKitFrameWork.h>
#import <SafariServices/SafariServices.h>
#import "UIView+Toast.h"
#import "ScanditFileController.h"
@interface ScanditWebController ()<WKUIDelegate,WKNavigationDelegate,DefaultScanDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UIProgressView *progressView;



@property (nonatomic,strong)WKWebView *webView;

@property (nonatomic,strong)UITextField *textfield;

@property (nonatomic,copy)NSString *urlStr;

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UILabel *tLabel;


@end

@implementation ScanditWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"pnl信息";
    self.view.backgroundColor  = RGBA(242, 242, 242, 1);
    [self setupSearchBar];
    
    UIView *touchView  =[[UIView alloc]init];
    touchView.frame = CGRectMake(0, 0, 120, 60);
    UIBarButtonItem * leftItem =[[UIBarButtonItem alloc]initWithCustomView:touchView];
    UILongPressGestureRecognizer  *longGuest =  [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longMethod)];
    [touchView addGestureRecognizer:longGuest];
    longGuest.allowableMovement  =NO;
    longGuest.minimumPressDuration  =0.5;
    self.navigationItem.leftBarButtonItem =leftItem;
    
    
}

-(void)longMethod{
    NSString *ipStr= [[NSUserDefaults standardUserDefaults]objectForKey:@"IPURL"];
    
    UIAlertController *controller  =[UIAlertController alertControllerWithTitle:@"已配置IP" message:ipStr?:NetworkServerAddress preferredStyle:UIAlertControllerStyleAlert];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
    }];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textfield  =  [controller.textFields firstObject];
        if (textfield.text.length <=0) {
            [Units showErrorStatusWithString:@"请输入正确的IP地址"];
            return;
        }
        if ([[textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] ==0) {
            [Units showErrorStatusWithString:@"请输入正确的IP地址"];
            return;
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:textfield.text forKey:@"IPURL"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        debugLog(@"text %@",textfield.text);
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)setupSearchBar{
    
    UIButton *but  =[UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:[UIImage imageNamed:@"iconfontscan"] forState:UIControlStateNormal];
    but.frame  =CGRectMake(0, 0, 60, 40);
    [but addTarget:self action:@selector(butMethod) forControlEvents:UIControlEventTouchUpInside];
    
  
    
    
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:but];
    
    self.navigationItem.rightBarButtonItem  =rightItem;
    
    UIView *bgView =[[UIView alloc]init];
    bgView.frame  = CGRectMake(1, 1, kScreenWidth-2, 48);
    bgView.layer.borderWidth =0.5;
    bgView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    bgView.layer.cornerRadius =2;
    bgView.clipsToBounds =YES;
    bgView.backgroundColor  =[UIColor whiteColor];
    self.bgView =bgView;
    [self.view addSubview:bgView];

    UILabel *titleLab =[[UILabel alloc]init];
    titleLab.text  =@"扫码信息";
    titleLab.font  =[UIFont systemFontOfSize:14];
    titleLab.textColor  =[UIColor blackColor];
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.centerY.mas_equalTo(bgView);
        make.width.mas_equalTo(73);
        make.height.mas_equalTo(48);
    }];
    
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor  =[UIColor lightGrayColor];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab.mas_right).mas_offset(3);
        make.top.bottom.mas_offset(0);
        make.width.mas_equalTo(0.5);
    }];
   
    
    UITextField  *textfiled  =[[UITextField alloc]init];
    textfiled.font  =[UIFont systemFontOfSize:14];
    textfiled.textColor  =[UIColor blackColor];
    textfiled.delegate  =self;
    textfiled.placeholder =@"扫码信息";
    textfiled.returnKeyType  =UIReturnKeySearch;
    self.textfield  =textfiled;
    [bgView addSubview:textfiled];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLab.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(bgView);
        make.right.mas_offset(-8);
        make.height.mas_equalTo(37);
        
    }];
    
    UILabel * codeLab  =[[UILabel alloc]init];
    codeLab.textColor =[UIColor blackColor];
    codeLab.font  =[UIFont systemFontOfSize:13];
    codeLab.backgroundColor =[UIColor whiteColor];
    codeLab.text =@"目前支持的码包括:PNL码,仓位码,托盘码";
    [self.view addSubview:codeLab];
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(2);
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(2);
        make.right.mas_offset(4);
        make.height.mas_equalTo(21);
    }];
    
    UILabel * tLabel  =[[UILabel alloc]init];
    tLabel.text =@"暂无数据";
    tLabel.textAlignment =NSTextAlignmentCenter;
    tLabel.textColor  =[UIColor lightGrayColor];
    self.tLabel  =tLabel;
    [self.view addSubview:tLabel];
    KWeakSelf
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.view);
        make.centerX.mas_equalTo(weakSelf.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
    }];
    
   //
    
    
    
    
}

-(void)setupWebViewWithUrl:(NSString*)url{
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.webView reload];
    
   // self.urlStr  = @"http://ww.baidu.com";
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
 
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
   // self.textfield.text  = self.urlStr;
    [self.view bringSubviewToFront:self.progressView];
}
 
//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    self.tLabel.hidden  =YES;
    self.webView.hidden  =NO;
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}
 
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    self.tLabel.hidden  =NO;
    [Units showErrorStatusWithString:@"加载失败!!!"];
    self.webView.hidden  =YES;
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}


  
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        //[webView loadRequest:navigationAction.request];
 //     NSURL *url=  navigationAction.request.URL;
//        SFSafariViewController *sfController  =[[SFSafariViewController alloc]initWithURL:url];
//        [self presentViewController:sfController animated:YES completion:nil];
        
        ScanditFileController *controller  =[[ScanditFileController alloc]init];
       

        controller.urlRequest  = navigationAction.request;
        [self.navigationController pushViewController:controller animated:YES];
        
        
    }
    return nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    if (textField.text.length >0) {
        NSString *str  =[[NSUserDefaults standardUserDefaults]objectForKey:@"IPURL"];
        [self setupWebViewWithUrl:[NSString stringWithFormat:@"%@%@",str?:NetworkServerAddress,textField.text]];
        debugLog(@"url  %@ %@",str,NetworkServerAddress);
    }else{
        [Units showStatusWithStutas:@"码信息不能为空"];
    }
    
    return  true;
}
-(void)butMethod{
    [self.view endEditing:YES];
    
    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:FALSE];
    HmsDefaultScanViewController *hmsDefaultScanViewController = [[HmsDefaultScanViewController alloc] initDefaultScanWithFormatType:options];
    hmsDefaultScanViewController.defaultScanDelegate = self;


  //  [self.navigationController pushViewController:hmsDefaultScanViewController animated:YES];
    [self.view addSubview:hmsDefaultScanViewController.view];
    [self addChildViewController:hmsDefaultScanViewController];
    [self didMoveToParentViewController:hmsDefaultScanViewController];
    self.navigationController.navigationBarHidden = YES;
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
   // self.resultStr  =toastString;
    self.urlStr  = toastString;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textfield.text  =toastString;
        NSString *url   =[[NSUserDefaults standardUserDefaults]objectForKey:@"IPURL"];
        [self setupWebViewWithUrl:[NSString stringWithFormat:@"%@%@",url?:NetworkServerAddress,toastString]];
        debugLog(@" - - -%@%@  %@",url,toastString,self.webView);
        debugLog(@" ttt%@",toastString);
    });
   
   // [self getdatasWithCode:toastString];
}
-(void)SearchCode{
    [self.view endEditing:YES];
    if (self.textfield.text.length ==0) {
        [Units showErrorStatusWithString:@"请输入码信息!!!"];
        return;
    }
    if (self.textfield.text.length >0) {
        self.urlStr  =self.textfield.text;
        [self setupWebViewWithUrl:self.textfield.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //点击UITextField，全选文字
    UITextPosition *endDocument = textField.endOfDocument;//获取 text的 尾部的 TextPositext
    
    UITextPosition *end = [textField positionFromPosition:endDocument offset:0];
    UITextPosition *start = [textField positionFromPosition:end offset:-textField.text.length];//左－右＋
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
   
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    //点击UITextField，全选文字
    UITextPosition *beginDocument = textField.beginningOfDocument;
    UITextPosition *end = [textField positionFromPosition:beginDocument offset:0];
    UITextPosition *start = [textField positionFromPosition:beginDocument offset:0];//左－右＋
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(WKWebView*)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate  =self;
        _webView.navigationDelegate  =self;
        _webView.scrollView.delegate =self;
        _webView.scrollView.showsVerticalScrollIndicator  =NO;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        _webView.autoresizesSubviews  =YES;
        _webView.allowsBackForwardNavigationGestures =true;
        _webView.multipleTouchEnabled  =YES;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(2);
            make.right.mas_offset(-2.5);
            make.bottom.mas_offset(-5);
           
            make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(2+22);
        }];
    }
    return _webView;
}



-(UIProgressView*)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.backgroundColor = [UIColor blueColor];
            //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.view addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(1);
            make.height.mas_equalTo(1);
        }];
    }
    return _progressView;
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
