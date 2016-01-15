//
//  PreferenceMap.m
//  Scene_Music
//
//  Created by checkyh on 16/1/15.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import "PreferenceMap.h"

@implementation PreferenceMap
-(PreferenceMap*)init
{
    _nDegree=[[NSMutableDictionary alloc]init];
    _keywords=[[NSMutableDictionary alloc]init];
    return self;
}
-(PreferenceMap*)initWithData:(NSDictionary *)data1 and:(NSDictionary *)data2
{
    _nDegree=[[NSMutableDictionary alloc]initWithDictionary:data1 copyItems:true];
    _keywords=[[NSMutableDictionary alloc]initWithDictionary:data2 copyItems:true];
    return self;
}
-(void)newfile:(MPMediaItem *)mediaItem
{
    NSDate *longAgo=[[NSDate alloc]initWithTimeIntervalSince1970:0];
    [_nDegree setValue:longAgo forKey:[mediaItem valueForKey:MPMediaItemPropertyTitle]];
}
-(void)listened:(MPMediaItem *)mediaItem
{
    [_nDegree setValue:[NSDate date] forKey:[mediaItem valueForKey:MPMediaItemPropertyTitle]];
    NSString *keyword;NSNumber *score=nil;
    
    keyword=[mediaItem valueForKey:MPMediaItemPropertyArtist];
    score=[_keywords objectForKey:keyword];
    if(score!=nil)
        [_keywords setValue:[NSNumber numberWithInt:[score integerValue]+5] forKey:keyword];
    else
        [_keywords setValue:[NSNumber numberWithInt:5] forKey:keyword];

    keyword=[mediaItem valueForKey:MPMediaItemPropertyAlbumTitle];
    score=[_keywords objectForKey:keyword];
    if(score!=nil)
        [_keywords setValue:[NSNumber numberWithInt:[score integerValue]+5] forKey:keyword];
    else
        [_keywords setValue:[NSNumber numberWithInt:5] forKey:keyword];

}
-(NSInteger)getScore:(MPMediaItem*)mediaItem
{
    NSInteger score=0;
    NSDate* date=[_nDegree objectForKey:[mediaItem valueForKey:MPMediaItemPropertyTitle]];
    NSDate* currentTime=[NSDate date];
    if([currentTime timeIntervalSinceDate:date]>2*60*60)
        score+=10;
    score+=[[_keywords valueForKey:[mediaItem valueForKey:MPMediaItemPropertyArtist]]integerValue];
    score+=[[_keywords valueForKey:[mediaItem valueForKey:MPMediaItemPropertyAlbumTitle]]integerValue];
    return score;
}
@end
