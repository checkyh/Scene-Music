//
//  LocationViewController.m
//  Scene_Music
//
//  Created by checkyh on 16/1/6.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ChorusAppDelegate.h"
@interface LocationViewController ()  <CLLocationManagerDelegate,MKMapViewDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (weak,nonatomic) IBOutlet MKMapView *mapView;
@property double latitude;
@property double longtitude;
@end

@implementation LocationViewController

- (IBAction)SetLocation:(id)sender {
    ChorusAppDelegate *temp=[[UIApplication sharedApplication]delegate];
    [temp.corePlayer SetHomeLocaton:self.latitude With:self.longtitude];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    [self startStandardUpdates];
    [self.mapView setDelegate:self];
    self.mapView.showsUserLocation=YES;
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
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error.description);
}

-(void)mapView:(MKMapView*)mapView didUpdateUserLocation:(nonnull MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
    [self.mapView setRegion:region animated:YES];
}


@end
