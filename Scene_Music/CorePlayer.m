//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"
#import "Location.h"
@interface CorePlayer()
@property double homeL1;
@property double homeL2;
@property Location *location;
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
        self.homeL1=[userdata doubleForKey:@"homeL1"];
        self.homeL2=[userdata doubleForKey:@"homeL2"];
    }
    else _suggestCollection=[NSMutableArray alloc];
    
    [self loadNewMusic];
    if(_suggestCollection.count>0){
        MPMediaItemCollection *list=[[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
        [self.audioPlayer setQueueWithItemCollection:list];
        [self.audioPlayer setRepeatMode:MPMusicRepeatModeAll];
        [self playWithIndex:0];
    }
    self.location= [[Location alloc]init];
    [self.location startStandardUpdates];
    
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
-(void)clearDefaults
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"suggest"];
    [[NSUserDefaults standardUserDefaults]setDouble:0 forKey:@"homeL1"];
    [[NSUserDefaults standardUserDefaults]setDouble:0 forKey:@"homeL2"];
    
}
-(void)SetHomeLocaton:(double)latitude With:(double)longtitude
{
    self.homeL1=latitude;
    self.homeL2=longtitude;
    NSLog(@"set HomeLocation");
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    if(userdata){
        [userdata setDouble:self.homeL1 forKey:@"homeL1"];
        
        [userdata setDouble:self.homeL2 forKey:@"homeL2"];
    }
}
-(Boolean)inHome
{
    NSLog(@"Home: %f   %f",self.homeL1,self.homeL2);
    NSLog(@"Current:%f  %f",self.currentL1,self.currentL2);
    double dis1=self.currentL1-self.homeL1;
    double dis2=self.currentL2-self.homeL2;
    if(dis1>-0.0005&&dis1<0.0005&&dis2>-0.0005&&dis2
       <0.0005)
        return true;
    else return false;
}
@end
