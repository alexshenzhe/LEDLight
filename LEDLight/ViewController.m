//
//  ViewController.m
//  LEDLight
//
//  Created by 沈喆 on 16/7/9.
//  Copyright © 2016年 沈喆. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *ledButton;

@end

@implementation ViewController {
    BOOL isTurnOn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ledButton = [[UIButton alloc] init];
    
    NSInteger ledX = 160;
    NSInteger ledY = 100;
    NSInteger ledW = 90;
    NSInteger ledH = 90;
    self.ledButton.frame = CGRectMake(ledX, ledY, ledW, ledH);
    
    [self.ledButton addTarget:self action:@selector(setLED) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonImage:self.ledButton isTurnOn:isTurnOn];
    
    [self.view addSubview:self.ledButton];
    
    
}

- (void)setLED {
    if (isTurnOn) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
        isTurnOn = NO;
        [self setButtonImage:self.ledButton isTurnOn:isTurnOn];
    } else {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOn];
            [device unlockForConfiguration];
        }
        isTurnOn = YES;
        [self setButtonImage:self.ledButton isTurnOn:isTurnOn];
    }
}

- (void)setButtonImage:(UIButton *)ledButton isTurnOn:(BOOL)isTurn {
    UIImage *LED_on = [UIImage imageNamed:@"LED_on"];
    UIImage *LED_off = [UIImage imageNamed:@"LED_off"];
    
    if (isTurn) {
        [ledButton setBackgroundImage:LED_on forState:UIControlStateNormal];
        [ledButton setBackgroundImage:LED_off forState:UIControlStateHighlighted];
    } else {
        [ledButton setBackgroundImage:LED_off forState:UIControlStateNormal];
        [ledButton setBackgroundImage:LED_on forState:UIControlStateHighlighted];
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
