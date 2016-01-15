//
//  PreferenceMap.h
//  Scene_Music
//
//  Created by checkyh on 16/1/15.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface PreferenceMap : NSObject
@property (strong,nonatomic) NSMutableDictionary *keywords;
@property (strong,nonatomic) NSMutableDictionary *nDegree;
-(void)newfile:(MPMediaItem *) mediaItem;
-(void)listened:(MPMediaItem *)mediaItem;
-(NSInteger)getScore:(MPMediaItem*)mediaItem;
-(PreferenceMap*)initWithData:(NSDictionary *)data1 and:(NSDictionary *)data2;
@end
