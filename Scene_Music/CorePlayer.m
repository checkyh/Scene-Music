//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"
@interface CorePlayer()
@property double homeL1;
@property double homeL2;
@end
@implementation CorePlayer

-(void)loadNewMusic
{
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    Boolean judge=true;
    for (MPMediaItem *qitem in mediaQueue.items) {
        judge=true;
        
        for(MPMediaItem *item in _suggestCollection)
            if([item isEqual:qitem]) {judge=false;break;}
        if(judge) 
            [_suggestCollection insertObject:qitem atIndex:0];
    }
    for (int i=(int)_suggestCollection.count-1;i>=0;i--)
    {
            judge=false;
            for(MPMediaItem *qitem in mediaQueue.items)
                if([[_suggestCollection objectAtIndex:i] isEqual:qitem]) {judge=true;break;}
            if(!judge)
            {
                [_suggestCollection removeObject:[_suggestCollection objectAtIndex:i]];
            }
    }
    [self saveState];
    
}
-(void)init_Music
{
    self.audioPlayer = [MPMusicPlayerController systemMusicPlayer];
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    if(userdata){
        NSData *data=[userdata objectForKey:@"suggest"];
        _suggestCollection=[[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data] copyItems:true];
    }
    else _suggestCollection=[NSMutableArray alloc];
    
    [self loadNewMusic];
    if(_suggestCollection.count>0){
        MPMediaItemCollection *list=[[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
        [self.audioPlayer setQueueWithItemCollection:list];
        [self.audioPlayer setRepeatMode:MPMusicRepeatModeAll];
        [self playWithIndex:0];
    }
}
-(void)playWithItem:(MPMediaItem *)mediaItem
{
    if(_suggestCollection.count>0){
    [self.audioPlayer setNowPlayingItem:mediaItem];
    [self.audioPlayer play];
    [_suggestCollection removeObject:mediaItem];
    [_suggestCollection insertObject:mediaItem atIndex:_suggestCollection.count];
    }
}
-(void)playWithIndex:(NSUInteger)index
{
    [self playWithItem:[_suggestCollection objectAtIndex:index]];
}
-(MPMediaItemCollection*)getCollection{
    if(_suggestCollection.count>0)
    return [[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
    else return NULL;
}
-(void)saveState
{
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_suggestCollection];
    if(userdata){
        [userdata setObject:data  forKey:@"suggest"];
    }
}
-(void)SetHomeLocaton:(double)latitude With:(double)longtitude
{
    self.homeL1=latitude;
    self.homeL2=longtitude;
    NSLog(@"set HomeLocation as");
}
@end
