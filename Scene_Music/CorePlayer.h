//
//  CorePlayer.h
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ChorusSongsViewController.h"
@interface CorePlayer : NSObject
@property (strong, nonatomic) MPMusicPlayerController *audioPlayer;
@property(strong,nonatomic) NSMutableArray* suggestCollection;

-(void)init_Music;
-(void)playWithItem:(MPMediaItem*)mediaItem;
-(void)playWithIndex:(NSUInteger)index;

-(MPMediaItemCollection*)getCollection;

-(void)saveState;
-(void)loadNewMusic;
-(void)clearDefaults;

-(void)SetHomeLocaton:(double) latitude With:(double) longtitude;
-(Boolean)inHome;
@property double currentL1;
@property double currentL2;
@end
