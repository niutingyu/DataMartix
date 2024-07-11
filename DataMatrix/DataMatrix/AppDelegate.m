//
//  AppDelegate.m
//  DataMatrix
//
//  Created by Andy on 2021/11/4.
//

#import "AppDelegate.h"
#import "DataMatrixCodeController.h"
#import "QRBaseNavController.h"
#import "ScanditWebController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor  =[UIColor whiteColor];
    ScanditWebController *controller  =[[ScanditWebController alloc]init];
    QRBaseNavController *nav  =[[QRBaseNavController alloc]initWithRootViewController:controller];
    self.window.rootViewController  =nav;
    [self.window makeKeyAndVisible];
    return YES;
}



@end
