//
//  ChorusAppDelegate.h
//  chorusTest
//
//  Created by Deepkanwal Plaha on 2/8/2014.
//  Copyright (c) 2014 Deepkanwal Plaha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlayer.h"
@interface ChorusAppDelegate : UIResponder <UIApplicationDelegate>
{
    CorePlayer* corePlayer;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) CorePlayer* corePlayer;
@end
