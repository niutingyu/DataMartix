//
//  ScanditController.m
//  DataMatrix
//
//  Created by Andy on 2021/11/10.
//

#import "ScanditController.h"


@import ScanditBarcodeCapture;

static NSString *const _Nonnull licenseKey = @"AejQd2NCQvkqNMrEREQPTw02rYwJABlEm3Y8MMAlkIaARVyp0HzAr0N6gZvadVB3cQy9SBlKfbLEQqKfHWbxIG90h7CuVaqjvXQSeCgLWOgZakMoh0495nMd8/jyOOJ2YEQBN6cgp1AkufnetcTvBo8Dk3tPR0nAaoHMWkMoptU2VeK/ZDFuhk2D1sBF2ySmKLpM+eP/Ni2gJ2DlCRcNaGuVZTa2a1Sy9/bLBy3m4YtEBCiBPewky8xjU62yNPzJvDyPde9clsl3agqs2ojaBt9A/KlhYvKUoeMYYsz1tRWM/XO8vbn+4CRSSV/lFBFM3T40J67/jeX/Qmt3TtMmHZCwfjolPwfLUiuipDhIVv7CiLP+erdAkHSyBa5ZpKMrLonAO+0akeaUvq6+Bj1K4EX2Rr05ljYnkE2p8bKR9SVlbywscTgVTNdqJY3oOn5SXtatZImu077tDmal7E+TykADGl6yesxZD1jR4lmeRUcsZT63/n93Mvinm5Bb/YlN4nfK3UJAOfqaYRhx5Mepd2CP73z2O0SkY5jT6KZBQBvgas3t4v3qHiK5BrAjpsceLQhUvkPm8S6B2RDGveycTtWV0ejaLcscv+Ts55rkRriH70cIe0GC77bA7QH75pMZsjbkkQEtYnPQo0GjFtMIxrj1mXUT1G4FMzGOxCj4VhNvanKWP2fWIILv+SMPSLS3dBo/NLfTMot+hNWCT9JRBlYUPtoUZkTbQUiCpg+poffCp5ZKyfmURXBzSBg99eLzQDgiLpUx90OTQnAJ/DKMv3RPPCpwYIDhAxG9EabUIru4v6PFrtHT6A==";

@implementation SDCDataCaptureContext (Licensed)

// Get a licensed DataCaptureContext.
+ (SDCDataCaptureContext *)licensedDataCaptureContext {
    return [self contextForLicenseKey:licenseKey];
}

@end
@interface ScanditController ()<SDCBarcodeCaptureListener>
@property (strong, nonatomic) SDCDataCaptureContext *context;
@property (strong, nonatomic, nullable) SDCCamera *camera;
@property (strong, nonatomic) SDCBarcodeCapture *barcodeCapture;
@property (strong, nonatomic) SDCDataCaptureView *captureView;
@property (strong, nonatomic) SDCBarcodeCaptureOverlay *overlay;
@end

@implementation ScanditController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.barcodeCapture.enabled = YES;
    [self.camera switchToDesiredState:SDCFrameSourceStateOn];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.barcodeCapture.enabled = NO;
    [self.camera switchToDesiredState:SDCFrameSourceStateOff];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"扫码";
    [self setupRecognition];
}

- (void)setupRecognition {
    // Create data capture context using your license key.
    self.context = [SDCDataCaptureContext licensedDataCaptureContext];

    // Use the world-facing (back) camera and set it as the frame source of the context. The camera
    // is off by default and must be turned on to start streaming frames to the data capture context
    // for recognition. See viewWillAppear and viewDidDisappear above.
    self.camera = SDCCamera.defaultCamera;

    // Use the recommended camera settings for the BarcodeCapture mode.
    SDCCameraSettings *recommendedCameraSettings = [SDCBarcodeCapture recommendedCameraSettings];
    recommendedCameraSettings.focusRange  =SDCVideoResolutionAuto;
    recommendedCameraSettings.preferredResolution  =SDCFocusRangeFar;
    [self.camera applySettings:recommendedCameraSettings completionHandler:nil];

    [self.context setFrameSource:self.camera completionHandler:nil];

    // The barcode capturing process is configured through barcode capture settings that first need
    // to be configured and are then applied to the barcode capture instance that manages barcode
    // recognition.
    SDCBarcodeCaptureSettings *settings = [SDCBarcodeCaptureSettings settings];

    // The settings instance initially has all types of barcodes (symbologies) disabled. For the
    // purpose of this sample we enable a very generous set of symbologies. In your own app ensure
    // that you only enable the symbologies that your app requires as every additional symbology
    // enabled has an impact on processing times.
//    [settings setSymbology:SDCSymbologyEAN13UPCA enabled:YES];
//    [settings setSymbology:SDCSymbologyEAN8 enabled:YES];
//    [settings setSymbology:SDCSymbologyUPCE enabled:YES];
    [settings setSymbology:SDCSymbologyQR enabled:YES];
    [settings setSymbology:SDCSymbologyDataMatrix enabled:YES];
//    [settings setSymbology:SDCSymbologyCode39 enabled:YES];
//    [settings setSymbology:SDCSymbologyCode128 enabled:YES];
    [settings setSymbology:SDCSymbologyInterleavedTwoOfFive enabled:YES];

    // Some linear/1d barcode symbologies allow you to encode variable-length data. By default, the
    // Scandit Data Capture SDK only scans barcodes in a certain length range. If your application
    // requires scanning of one of these symbologies, and the length is falling outside the default
    // range, you may need to adjust the "active symbol counts" for this symbology. This is shown in
    // the following few lines of code for one of the variable-length symbologies.
    SDCSymbologySettings *symbologySettings = [settings settingsForSymbology:SDCSymbologyCode39];
    symbologySettings.activeSymbolCounts = [NSSet
        setWithObjects:@7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, nil];

    // Create new barcode capture mode with the settings from above.
    self.barcodeCapture = [SDCBarcodeCapture barcodeCaptureWithContext:self.context
                                                              settings:settings];

    // Register self as a listener to get informed whenever a new barcode got recognized.
    [self.barcodeCapture addListener:self];

    // To visualize the on-going barcode capturing process on screen, setup a data capture view that
    // renders the camera preview. The view must be connected to the data capture context.
    self.captureView = [[SDCDataCaptureView alloc] initWithFrame:self.view.bounds];
    self.captureView.context = self.context;
    self.captureView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                        UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.captureView];

    // Add a barcode capture overlay to the data capture view to render the location of captured
    // barcodes on top of the video preview. This is optional, but recommended for better visual
    // feedback.
    
    self.overlay = [SDCBarcodeCaptureOverlay
         overlayWithBarcodeCapture:self.barcodeCapture
               forDataCaptureView:self.captureView];
   // self.overlay.viewfinder = [SDCRectangularViewfinder
   //     viewfinderWithStyle:SDCRectangularViewfinderStyleSquare
   //               lineStyle:SDCRectangularViewfinderLineStyleLight];
   // sdcrect
    
}

- (void)showResult:(nonnull NSString *)result completion:(nonnull void (^)(void))completion {
  KWeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.toastResult) {
            weakSelf.toastResult(result);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
//        UIAlertController *alert = [UIAlertController
//            alertControllerWithTitle:result
//                             message:nil
//                      preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
//                                                  style:UIAlertActionStyleDefault
//                                                handler:^(UIAlertAction *_Nonnull action) {
//                                                    completion();
//                                                }]];
//        [self presentViewController:alert animated:YES completion:nil];
    });
}

// MARK: - SDCBarcodeCaptureListener

- (void)barcodeCapture:(SDCBarcodeCapture *)barcodeCapture
      didScanInSession:(SDCBarcodeCaptureSession *)session
             frameData:(id<SDCFrameData>)frameData {
    SDCBarcode *barcode = [session.newlyRecognizedBarcodes firstObject];
    if (barcode == nil || barcode.data == nil) {
        return;
    }

    // Stop recognizing barcodes for as long as we are displaying the result. There won't be any new
    // results until the capture mode is enabled again. Note that disabling the capture mode does
    // not stop the camera, the camera continues to stream frames until it is turned off.
    self.barcodeCapture.enabled = NO;

    // If you are not disabling barcode capture here and want to continue scanning, consider
    // setting the codeDuplicateFilter when creating the barcode capture settings to around 500
    // or even -1 if you do not want codes to be scanned more than once.

    // Get the human readable name of the symbology and assemble the result to be shown.
    NSString *symbology =
        [[SDCSymbologyDescription alloc] initWithSymbology:barcode.symbology].readableName;
    NSString *result = [NSString stringWithFormat:@"Scanned %@ (%@)", barcode.data, symbology];

   KWeakSelf
    [self showResult:result
          completion:^{
              // Enable recognizing barcodes when the result is not shown anymore.
              weakSelf.barcodeCapture.enabled = YES;
          }];
}

@end
