//
//  cameraFoundationVC.h
//  ludipics
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    PositionBack,
    PositionFront
} CameraPosition;

typedef enum : NSUInteger {
    QualityLow,
    QualityMedium,
    QualityHigh,
    QualityPhoto
} CameraQuality;

typedef enum : NSUInteger {
    CameraFlashOn,
    CameraFlashOff,
    CameraFlashAuto
} CameraFlash;


@protocol cameraFoundationVCDelegate;

@interface cameraFoundationVC : UIViewController
@property (strong, nonatomic) UIView *viewFinder;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageAVCapture;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDeviceInput * videoDeviceInput;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;
@property (strong, nonatomic) AVCaptureDevice *audioDevice;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (assign, nonatomic) CGFloat videoZoomFactor;
@property (nonatomic) BOOL videoCapturing;
@property (nonatomic) BOOL recording;
@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic, copy) void (^completedRecord)(cameraFoundationVC *camera, NSURL *outputFileUrl, NSError *error);

@property (nonatomic, strong) id<cameraFoundationVCDelegate> delegate;

@property (nonatomic) CameraFlash cameraFlash;

@property (nonatomic) CameraPosition cameraPosition;

+(cameraFoundationVC *)camera:(CameraQuality)quality;

-(id) initWithQuality:(CameraQuality)quality;

-(void)cameraStart;

-(void)cameraStop;

-(void)attachToViewController:(UIViewController *)vc withDelegate:(id<cameraFoundationVCDelegate>)delegate;

-(CameraPosition)togglePosition;

-(CameraFlash)toggleFlash;

-(BOOL)isFlashAvailable;

-(void)capture;

-(void)focus:(CGPoint)touchPoint;

- (void)handleZoomPinch:(UIPinchGestureRecognizer *)recognizer;
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

-(void) startRecordingWithURL:(NSURL *)url;
- (void)stopRecording:(void (^)(cameraFoundationVC *camera, NSURL *outputFileUrl, NSError *error))completionBlock;
@end
@protocol cameraFoundationVCDelegate <NSObject>

- (void)cameraViewController:(cameraFoundationVC*)cameraVC
             didChangeDevice:(AVCaptureDevice *)device;

- (void)cameraViewController:(cameraFoundationVC*)cameraVC
             didCaptureImage:(UIImage *)image;



@end