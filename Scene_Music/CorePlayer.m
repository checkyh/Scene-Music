//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@implementation CorePlayer

-(void)init_Music
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.audioPlayer = [MPMusicPlayerController systemMusicPlayer];
}
-(void)play:(MPMediaItem*)mediaItem
{
    [self.audioPlayer setNowPlayingItem:mediaItem];
    [self.audioPlayer play];
}
@end
