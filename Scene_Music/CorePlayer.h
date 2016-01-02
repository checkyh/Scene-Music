//
//  CorePlayer.h
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface CorePlayer : NSObject
@property (strong, nonatomic) MPMusicPlayerController *audioPlayer;
@property(strong,nonatomic) NSMutableArray* suggestCollection;
-(void)init_Music;
-(void)play:(MPMediaItem*)mediaItem;
-(MPMediaItemCollection*)getCollection;
@end
