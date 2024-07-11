//
//  ScanditFileController.m
//  DataMatrix
//
//  Created by Andy on 2022/11/3.
//

#import "ScanditFileController.h"
#import <WebKit/WebKit.h>
@interface ScanditFileController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) UIProgressView *progressView;



@property (nonatomic,strong)WKWebView *webView;
@end

@implementation ScanditFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"附件信息";
   // [self.webView loadRequest:self.urlRequest];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
   
//    UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem  =leftItem;
    
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
  
    [self.view bringSubviewToFront:self.progressView];
}
 
//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
 
    self.webView.hidden  =NO;
   
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
}
 
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
   
    [Units showErrorStatusWithString:@"加载失败!!!"];
    self.webView.hidden  =YES;
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}
-(WKWebView*)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate  =self;
        _webView.navigationDelegate  =self;
        _webView.scrollView.delegate =self;
        _webView.backgroundColor  =RGBA(242, 242, 242, 1);
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        _webView.autoresizesSubviews  =YES;
        _webView.allowsBackForwardNavigationGestures =true;
        _webView.multipleTouchEnabled  =YES;
        [_webView loadRequest:self.urlRequest];
       
       
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_offset(0);
            
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
            make.top.mas_offset(1);
            make.height.mas_equalTo(1.5);
        }];
    }
    return _progressView;
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
