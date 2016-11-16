//
//  WIAFirstLaunchViewController.m
//  wia
//
//  Created by Abbin Varghese on 15/11/16.
//  Copyright © 2016 What I Ate. All rights reserved.
//

#import "WIAFirstLaunchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WIAColor.h"

@interface WIAFirstLaunchViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) AVPlayer *avplayer;

@end

@implementation WIAFirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nextButton.layer.cornerRadius = 50/7;
    self.nextButton.layer.masksToBounds = YES;
    
    self.playerView.layer.cornerRadius = self.nextButton.layer.cornerRadius;
    self.playerView.layer.masksToBounds = YES;
    
    self.nextButton.backgroundColor = [WIAColor mainColor];
    
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0102" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-30), ([UIScreen mainScreen].bounds.size.width-30)*9/16)];
    [self.playerView.layer addSublayer:avPlayerLayer];
    
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.avplayer pause];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.avplayer play];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying{
    [self.avplayer play];
}

@end
