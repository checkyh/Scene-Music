//
//  QueueController.h
//  Scene_Music
//
//  Created by checkyh on 16/1/15.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PreferenceMap.h"
@interface QueueController : NSObject
@property (strong,nonatomic) PreferenceMap *outPre;
@property (strong,nonatomic) PreferenceMap *homePre;
@property NSInteger chooser;
-(void)newfile:(MPMediaItem *) mediaItem;
-(void)listened:(MPMediaItem *)mediaItem;
-(NSInteger)getScore:(MPMediaItem*)mediaItem;
-(void)setDefault:(BOOL)home;
-(void)updateList:(NSMutableArray*)list;
-(QueueController *)initWithOutData:(NSDictionary*)outPreference1 and:(NSDictionary*)outPreference2 withHomeData:(NSDictionary *)homePreference1 and:(NSDictionary *)homePreference2;
@end
