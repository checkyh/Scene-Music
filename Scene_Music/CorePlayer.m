//
//  CorePlayer.m
//  Scene_Music
//
//  Created by checkyh on 15/12/14.
//  Copyright © 2015年 checkyh. All rights reserved.
//

#import "CorePlayer.h"
@interface CorePlayer()
@property (weak,nonatomic)UITableView *tableview;
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
    if(self.tableview!=NULL)[self.tableview reloadData];
    [self saveState];
    
}
-(void)init_Music
{
    self.tableview=NULL;
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
    }
    [self.audioPlayer setRepeatMode:MPMusicRepeatModeAll];
    [self.audioPlayer setNowPlayingItem:[_suggestCollection objectAtIndex:0]];
    [self.audioPlayer play];
}
-(void)playWithItem:(MPMediaItem *)mediaItem
{
    [self.audioPlayer setNowPlayingItem:mediaItem];
    [self.audioPlayer play];
}
-(void)playWithIndex:(NSUInteger)index
{
    [self playWithItem:[_suggestCollection objectAtIndex:index]];
}
-(MPMediaItemCollection*)getCollection{
    return [[MPMediaItemCollection alloc]initWithItems:_suggestCollection];
}
-(void)saveState
{
    NSUserDefaults *userdata=[NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_suggestCollection];
    if(userdata){
        [userdata setObject:data  forKey:@"suggest"];
    }
    if(self.tableview!=NULL)[self.tableview reloadData];
}
-(void)assignDynamicTableView:(UITableView *)aTableview
{
    self.tableview=aTableview;
}
@end
