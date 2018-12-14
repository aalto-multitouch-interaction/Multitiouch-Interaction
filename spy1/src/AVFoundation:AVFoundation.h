#ifndef AVFoundation_AVFoundation_h
#define AVFoundation_AVFoundation_h

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface audioViewController : UIViewController
<AVAudioPlayerDelegate>
{
    AVAudioPlayer *audioPlayer;
    UISlider *volumeControl;
}
@property (nonatomic, retain) IBOutlet UISlider *volumeControl;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
-(IBAction) playAudio;
-(IBAction) stopAudio;
-(IBAction) adjustVolume;

/*added*/
//[AVAudioSession sharedInstance];
//// @Boris edited: you may need it if there is no `AVAudioSession instance` created before. If doesn't work, uncomment this line.
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:)
//                                             name:AVAudioSessionRouteChangeNotification
//                                           object:nil];
//
//- (void)audioRouteChangeListenerCallback:(NSNotification*)notification
//{
//    NSDictionary *interuptionDict = notification.userInfo;
//
//    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
//
//    switch (routeChangeReason) {
//
//        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
//            NSLog(@"AVAudioSessionRouteChangeReasonNewDeviceAvailable");
//            NSLog(@"Headphone/Line plugged in");
//            break;
//
//        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
//            NSLog(@"AVAudioSessionRouteChangeReasonOldDeviceUnavailable");
//            NSLog(@"Headphone/Line was pulled. Stopping player....");
//            break;
//
//        case AVAudioSessionRouteChangeReasonCategoryChange:
//            // called at start - also when other audio wants to play
//            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
//            break;
//    }
//}
/*added*/

/*added2*/
- (BOOL)areHeadphonesPluggedIn {
    NSArray *availableOutputs = [[AVAudioSession sharedInstance] currentRoute].outputs;
    for (AVAudioSessionPortDescription *portDescription in availableOutputs) {
        if ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones]) {
            return YES;
            cout<<"out"<<endl;
        }
    }
    return NO;
}
/*added2*/

@end

