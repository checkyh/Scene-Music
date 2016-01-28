//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"
#import "Location.h"
#import "QueueController.h"
@interface CorePlayer()
@property double homeL1;
@property double homeL2;
@property Location *location;
@property QueueController* rank;
@end
@implementation CorePlayer

-(CorePlayer *)init
{
    [self init_Music];
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    if(userdata){
        NSData *data1=[userdata objectForKey:@"outPreference1"];
        
        NSData *data2=[userdata objectForKey:@"outPreference2"];
        
        NSData *data3=[userdata objectForKey:@"homePreference1"];
        
        NSData *data4=[userdata objectForKey:@"homePreference2"];
        _rank=[[QueueController alloc]initWithOutData:[[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data1] copyItems:true] and:[[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data2] copyItems:true] withHomeData:[[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data3] copyItems:true] and:[[NSDictionary alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data4] copyItems:true]];
    }
    else
    _rank=[[QueueController alloc]init];
    self.location= [[Location alloc]init];
    [self.location startStandardUpdates];
    return self;
}
-(void)loadNewMusic
{
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    Boolean judge=true;
    for (MPMediaItem *qitem in mediaQueue.items) {
        judge=true;
        for(MPMediaItem *item in _suggestCollection)
            if([item isEqual:qitem]) {judge=false;break;}
        if(judge){
            [_suggestCollection insertObject:qitem atIndex:0];
            [_rank newfile:qitem];
        }
    }
    for (int i=(int)_suggestCollection.count-1;i>=0;i--)
    {
            judge=false;
            for(MPMediaItem *qitem in mediaQueue.items)
                if([[_suggestCollection objectAtIndex:i] isEqual:qitem]) {judge=true;break;}
            if(!judge)
                [_suggestCollection removeObject:[_suggestCollection objectAtIndex:i]];
     
    }
    [self updateList];
    [self saveState];
}
-(void)updateList
{
    [_rank updateList:_suggestCollection];
    if(_suggestCollection.count>0){
        MPMediaItemCollection *list=[[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
        [self.audioPlayer setQueueWithItemCollection:list];
    }
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
    }
    
}
-(void)playWithItem:(MPMediaItem *)mediaItem
{
    if(_suggestCollection.count>0){
        [self.audioPlayer setNowPlayingItem:mediaItem];
        [self.audioPlayer play];
        [_rank listened:mediaItem];
        [self updateList];
        [self saveState];
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
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:_rank.homePre.nDegree];
    
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:_rank.homePre.keywords];
    
    NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:_rank.outPre.nDegree];
    
    NSData *data4 = [NSKeyedArchiver archivedDataWithRootObject:_rank.outPre.keywords];
    if(userdata){
        [userdata setObject:data  forKey:@"suggest"];
        [userdata setObject:data1 forKey:@"homePreference1"];
        [userdata setObject:data2 forKey:@"homePreference2"];
        [userdata setObject:data3 forKey:@"outPreference1"];
        [userdata setObject:data4 forKey:@"outPreference2"];
    }
}
-(void)clearDefaults
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"suggest"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"outPreference1"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"outPreference2"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"homePreference1"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"homePreference2"];
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
