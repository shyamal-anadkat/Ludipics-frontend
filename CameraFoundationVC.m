//
//  cameraFoundationVC.m
//  ludipics
//
//  Created by Ritvik Upadhyaya on 13/02/16.
//  Copyright © 2016 Ritvik Upadhyaya. All rights reserved.
//

#import "cameraFoundationVC.h"
#import <ImageIO/CGImageProperties.h>

@interface cameraFoundationVC () <AVCaptureFileOutputRecordingDelegate>
@property (nonatomic) CameraQuality cameraQuality;

@end

@implementation cameraFoundationVC
@synthesize captureDevice = _captureDevice;
-(id)initWithQuality:(CameraQuality)quality{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.cameraQuality = quality;
        self.videoZoomFactor = 1;
        self.videoCapturing = YES;
    }
    return self;
}
-(void)focus:(CGPoint)touchPoint{
    CGPoint convertedPoint = [self.videoPreviewLayer captureDevicePointOfInterestForPoint:touchPoint];
    AVCaptureDevice *currentDevice = _captureDevice;
    
    if([currentDevice isFocusPointOfInterestSupported] && [currentDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]){
        NSError *error = nil;
        [currentDevice lockForConfiguration:&error];
        if(!error){
            [currentDevice setFocusPointOfInterest:convertedPoint];
            [currentDevice setFocusMode:AVCaptureFocusModeAutoFocus];
            [currentDevice unlockForConfiguration];
        }
    }
}
//-----------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
//-----------------------------------------------------------------------------------
-(void)viewDidLoad{
    [super viewDidLoad];
    self.videoZoomFactor = 1;
    self.cameraFlash = CameraFlashOff;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    self.viewFinder = [[UIView alloc] initWithFrame:CGRectZero];
    self.viewFinder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.viewFinder];
}
- (void)attachToViewController:(UIViewController *)vc withDelegate:(id<cameraFoundationVCDelegate>)delegate {
    self.delegate = delegate;
    [vc.view addSubview:self.view];
    [vc addChildViewController:self];
    [self didMoveToParentViewController:vc];
}

- (void)cameraStart {
    self.videoZoomFactor = 1;
    if(!_session) {
        
        self.session = [[AVCaptureSession alloc] init];
        
        NSString *sessionPreset = nil;
        
        switch (self.cameraQuality) {
            case QualityHigh:
                sessionPreset = AVCaptureSessionPresetHigh;
                break;
            case QualityMedium:
                sessionPreset = AVCaptureSessionPresetMedium;
                break;
            case QualityLow:
                sessionPreset = AVCaptureSessionPresetLow;
                break;
            default:
                sessionPreset = AVCaptureSessionPresetPhoto;
                break;
        }
        
        self.session.sessionPreset = sessionPreset;
        
        CALayer *viewLayer = self.viewFinder.layer;
        
        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        
        
        
        // set size
        CGRect bounds=viewLayer.bounds;
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        captureVideoPreviewLayer.bounds=bounds;
        captureVideoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        [self.viewFinder.layer addSublayer:captureVideoPreviewLayer];
        
        self.videoPreviewLayer = captureVideoPreviewLayer;
        
        
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        
        NSError *error = nil;
        _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
        
        if (!_videoDeviceInput) {
            // Handle the error appropriately.
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            return;
        }
        [self.session addInput:_videoDeviceInput];
        
        if (_videoCapturing) {
            _audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
            AVCaptureDeviceInput * audioInput = [AVCaptureDeviceInput deviceInputWithDevice:_audioDevice error:&error];
            if (!audioInput) {
                //Handle if microphone was not allowed
            }
            
            [self.session addInput:audioInput];
            _movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
            [self.session addOutput:_movieFileOutput];
        }
        
        self.imageAVCapture = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.imageAVCapture setOutputSettings:outputSettings];
        [self.session addOutput:self.imageAVCapture];
    }
    
    
    [self.session startRunning];
}
- (void)cameraStop {
    [self.session stopRunning];
}

- (AVCaptureConnection *)captureConnection {
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.imageAVCapture.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    return videoConnection;
}

#pragma mark Video Methods
-(void) startRecordingWithURL:(NSURL *)url {
    [self.movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:self];
}

- (void)stopRecording:(void (^)(cameraFoundationVC *camera, NSURL *outputFileUrl, NSError *error))completionBlock {
    
    self.completedRecord = completionBlock;
    [self.movieFileOutput stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    self.recording = YES;
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    
    self.recording = NO;
    if(self.completedRecord) {
        self.completedRecord(self, outputFileURL, error);
    }
}
#pragma mark Image Capture
-(void)capture {
    
    AVCaptureConnection *videoConnection = [self captureConnection];
    
    [self.imageAVCapture captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments) {
             // Do something with the attachments.
             //NSLog(@"attachements: %@", exifAttachments);
         } else {
             //NSLog(@"no attachments");
         }
         
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         UIImage * flippedImage = [UIImage alloc];
         if (_cameraPosition == PositionFront) {
             flippedImage = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeftMirrored];
         }else{
             flippedImage = image;
         }
         
         if(self.delegate) {
             if ([self.delegate respondsToSelector:@selector(cameraViewController:didCaptureImage:)]) {
                 [self.delegate cameraViewController:self didCaptureImage:flippedImage];
             }
         }
     }
     ];
}

#pragma mark General Camera Set up
- (void)setCaptureDevice:(AVCaptureDevice *)captureDevice {
    _captureDevice = captureDevice;
    
    if(self.delegate) {
        if ([self.delegate respondsToSelector:@selector(cameraViewController:didChangeDevice:)]) {
            [self.delegate cameraViewController:self didChangeDevice:captureDevice];
        }
    }
}

- (BOOL)isFlashAvailable {
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    AVCaptureDeviceInput *deviceInput = (AVCaptureDeviceInput *)_videoDeviceInput;
    
    return !deviceInput.device.isFlashAvailable;
}

-(void)setCameraFlash:(CameraFlash)cameraFlash {
    
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    AVCaptureDeviceInput *deviceInput = (AVCaptureDeviceInput *)_videoDeviceInput;
    
    if(!deviceInput.device.isFlashAvailable) {
        return;
    }
    _cameraFlash = cameraFlash;
    
    [self.session beginConfiguration];
    [deviceInput.device lockForConfiguration:nil];
    
    if(_cameraFlash == CameraFlashOn) {
        deviceInput.device.flashMode = AVCaptureFlashModeOn;
    }
    else if(_cameraFlash == CameraFlashOff){
        deviceInput.device.flashMode = AVCaptureFlashModeOff;
    }else {
        deviceInput.device.flashMode = AVCaptureFlashModeAuto;
    }
    
    
    [deviceInput.device unlockForConfiguration];
    
    //Commit all the configuration changes at once
    [self.session commitConfiguration];
}

- (CameraPosition)togglePosition {
    if(self.cameraPosition == PositionBack) {
        self.cameraPosition = PositionFront;
    }
    else {
        self.cameraPosition = PositionBack;
    }
    
    return self.cameraPosition;
}

- (CameraFlash)toggleFlash {
    if(self.cameraFlash == CameraFlashOn) {
        self.cameraFlash = CameraFlashAuto;
    }
    else if(self.cameraFlash == CameraFlashAuto){
        self.cameraFlash = CameraFlashOff;
    }else{
        self.cameraFlash = CameraFlashOn;
    }
    
    return self.cameraFlash;
}
- (void)setCameraPosition:(CameraPosition)cameraPosition
{
    if(_cameraPosition == cameraPosition) {
        return;
    }
    
    //Indicate that some changes will be made to the session
    [self.session beginConfiguration];
    
    //Remove existing input
    AVCaptureInput* currentCameraInput = [self.session.inputs objectAtIndex:0];
    [self.session removeInput:_videoDeviceInput];
    
    //Get new input
    AVCaptureDevice *newCamera = nil;
    if(_videoDeviceInput.device.position == AVCaptureDevicePositionBack) {
        self.videoZoomFactor = 1;
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    else {
        self.videoZoomFactor = 1;
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    
    if(!newCamera) {
        return;
    }
    
    _cameraPosition = cameraPosition;
    
    // add input to session
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:nil];
    [self.session addInput:newVideoInput];
    
    // commit changes
    [self.session commitConfiguration];
    
    self.captureDevice = newCamera;
    self.videoDeviceInput = newVideoInput;
    
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) return device;
    }
    return nil;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //    NSLog(@"layout cameraVC : %d", self.interfaceOrientation);
    
    self.viewFinder.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    CGRect bounds=self.viewFinder.bounds;
    self.videoPreviewLayer.bounds=bounds;
    self.videoPreviewLayer.position=CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    
    self.videoPreviewLayer.connection.videoOrientation = videoOrientation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)videoZoomFactor {
    //AVCaptureDevice *device = [self captureDevice];
    
    return self.captureDevice.videoZoomFactor;
}

- (void)setVideoZoomFactor:(CGFloat)videoZoomFactor {
    AVCaptureDevice *device = [self captureDevice];
    
    if ([device respondsToSelector:@selector(videoZoomFactor)]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            if (videoZoomFactor <= device.activeFormat.videoMaxZoomFactor) {
                device.videoZoomFactor = videoZoomFactor;
            } else {
                NSLog(@"Unable to set videoZoom: (max %f, asked %f)", device.activeFormat.videoMaxZoomFactor, videoZoomFactor);
            }
            
            [device unlockForConfiguration];
        } else {
            NSLog(@"Unable to set videoZoom: %@", error.localizedDescription);
        }
    }
}
+(cameraFoundationVC *)camera:(CameraQuality)quality{
    return [[cameraFoundationVC alloc] initWithQuality:quality];
}


@end