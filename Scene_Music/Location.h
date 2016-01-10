//
//  Location.h
//  Scene_Music
//
//  Created by checkyh on 16/1/10.
//  Copyright © 2016年 checkyh. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface Location : UIViewController
- (void)startStandardUpdates;
-(void)setCurrentLocation;
@end

