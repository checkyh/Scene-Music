//
//  Location.m
//  Scene_Music
//
//  Created by checkyh on 16/1/10.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ChorusAppDelegate.h"
@interface Location ()  <CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;
@property double latitude;
@property double longtitude;
@end

@implementation Location

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestWhenInUse");
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
}


- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringSignificantLocationChanges];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* location = [locations lastObject];
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    self.latitude=location.coordinate.latitude;
    self.longtitude=location.coordinate.longitude;
    [self setCurrentLocation];
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    self.latitude=newLocation.coordinate.latitude;
    self.longtitude=newLocation.coordinate.longitude;
    [self setCurrentLocation];
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.description);
}

-(void)setCurrentLocation
{
    ChorusAppDelegate *temp=[[UIApplication sharedApplication]delegate];
    temp.corePlayer.currentL1=self.latitude;
    temp.corePlayer.currentL2=self.longtitude;
    NSLog(@"SetCurrentLocation");
}
@end