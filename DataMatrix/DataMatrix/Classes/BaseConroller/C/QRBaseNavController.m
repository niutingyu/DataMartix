//
//  QRBaseNavController.m
//  DataMatrixCode
//
//  Created by Andy on 2021/11/4.
//

#import "QRBaseNavController.h"

@interface QRBaseNavController ()

@end

@implementation QRBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];    // 文字颜色 图片
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *apprance =[[UINavigationBarAppearance alloc]init];
        apprance.backgroundColor =RGBA(70, 82, 177, 1);
        NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
            textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];//标题颜色
            textAttribute[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];//标题大小
            [apprance setTitleTextAttributes:textAttribute];
        self.navigationBar.standardAppearance =apprance;
        self.navigationBar.scrollEdgeAppearance =apprance;
        
    } else {
        // Fallback on earlier versions
    }
    
  
    self.navigationBar.barTintColor = RGBA(70, 82, 177, 1);
    self.navigationBar.barStyle =UIBarStyleBlackOpaque;
    self.navigationBar.translucent =NO;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
  //  [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17 weight:0.5]}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
