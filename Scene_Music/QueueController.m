//
//  QueueController.m
//  Scene_Music
//
//  Created by checkyh on 16/1/15.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import "QueueController.h"

@implementation QueueController
-(QueueController*)init
{
    _chooser=0;
    _homePre=[[PreferenceMap alloc]init];
    _outPre=[[PreferenceMap alloc]init];
    return self;
}
-(QueueController *)initWithOutData:(NSDictionary*)outPreference1 and:(NSDictionary*)outPreference2 withHomeData:(NSDictionary *)homePreference1 and:(NSDictionary *)homePreference2
{
    _outPre=[[PreferenceMap alloc]initWithData:outPreference1 and:outPreference2];
    _homePre=[[PreferenceMap alloc]initWithData:homePreference1 and:homePreference2];
    return self;
}
-(PreferenceMap *)choosePre
{
    if(_chooser==0) return _homePre;
    else return _outPre;
}
-(void)newfile:(MPMediaItem *)mediaItem
{
    PreferenceMap *current=[self choosePre];
    [current newfile:mediaItem];
}
-(void)listened:(MPMediaItem *)mediaItem
{
    PreferenceMap *current=[self choosePre];
    [current listened:mediaItem];
}
-(NSInteger)getScore:(MPMediaItem *)mediaItem
{
    PreferenceMap *current=[self choosePre];
    return [current getScore:mediaItem];
}
-(void)setDefault:(BOOL)home
{
    if(home)_chooser=0;
    else _chooser=1;
}
-(void)updateList:(NSMutableArray*)list
{
    MPMediaItem *com1,*com2;
    for(int i=0;i<list.count;i++)
        for(int j=i+1;j<list.count;j++){
            com1=[list objectAtIndex:i];
            com2=[list objectAtIndex:j];
            if([self getScore:com1]<[self getScore:com2])
                [list exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
}
@end
