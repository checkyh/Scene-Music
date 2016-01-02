//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"

@implementation CorePlayer

-(void)init_Music
{
    self.audioPlayer = [MPMusicPlayerController systemMusicPlayer];
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    if(userdata){
        _suggestCollection=[userdata objectForKey:@"suggest"];
    }
    else _suggestCollection=[NSMutableArray alloc];
    Boolean judge=true;
    for (MPMediaItem *qitem in mediaQueue.items) {
        judge=true;
        
        for(MPMediaItem *item in _suggestCollection)
            if(item.title== qitem.title) judge=false;
        if(judge) {
            [_suggestCollection insertObject:[qitem copy] atIndex:0];
        }
    }
    MPMediaItemCollection *list=[[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
    [self.audioPlayer setRepeatMode:MPMusicRepeatModeAll];
    [self.audioPlayer setQueueWithItemCollection:list];
    [self.audioPlayer play];
}
-(void)play:(MPMediaItem*)mediaItem
{
    [self.audioPlayer setNowPlayingItem:mediaItem];
    [self.audioPlayer play];
}
-(MPMediaItemCollection*)getCollection{
    return [[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
}
@end
