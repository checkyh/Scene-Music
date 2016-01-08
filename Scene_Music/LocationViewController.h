//
//  LocationViewController.h
//  Scene_Music
//
//  Created by checkyh on 16/1/6.
//  Copyright © 2016年 checkyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmButton;
- (IBAction)SetLocation:(id)sender;
@end
