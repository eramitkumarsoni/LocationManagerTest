//
//  LocationManager.m
//  LocationManagerTest
//
//  Created by Amit Soni on 23/08/14.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationManager
@synthesize locationManager;

- (void)registerLocations:(NSArray *)locations withIdentifiers:(NSArray *)identifiers andRadius:(double)radius
{
    
    if (locations.count == identifiers.count) {
        locationManager=[[CLLocationManager alloc]init ];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        [locationManager startUpdatingLocation];
        
        for (int index = 0; index < locations.count; index ++) {
            NSString *location = [locations objectAtIndex:index];
            NSArray *latLong = [location componentsSeparatedByString:@","];
            NSString *lat = [latLong objectAtIndex:0];
            NSString *lng = [latLong objectAtIndex:1];
            NSString *identifier = [identifiers objectAtIndex:index];
            
            CLLocation *locationToAdd = [[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:locationToAdd.coordinate radius:radius identifier:identifier];
            [self.locationManager startMonitoringForRegion:region];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registering region error !" message:@"Please check the locations and identifiers count" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region  {
    UILocalNotification *localNotificationTest = [[UILocalNotification alloc] init];
    localNotificationTest.alertBody = [NSString stringWithFormat:@"Entered region %@",region.identifier];
    [localNotificationTest setSoundName:UILocalNotificationDefaultSoundName];
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotificationTest];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	NSString *event = [NSString stringWithFormat:@"didExitRegion %@ at %@", region.identifier, [NSDate date]];
	NSLog(@"didExitRegion = %@",event);
    
    UILocalNotification *localNotificationTest = [[UILocalNotification alloc] init];
    localNotificationTest.alertBody = [NSString stringWithFormat:@"Exited region %@",region.identifier];
    [localNotificationTest setSoundName:UILocalNotificationDefaultSoundName];
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotificationTest];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
	NSString *event = [NSString stringWithFormat:@"monitoringDidFailForRegion %@: %@", region.identifier, error];
	NSLog(@"monitoringDidFailForRegion = %@",event);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"didStartMonitoringForRegion = %@",region.description);
}

@end
