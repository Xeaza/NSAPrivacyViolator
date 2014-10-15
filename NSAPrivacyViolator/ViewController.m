//
//  ViewController.m
//  NSAPrivacyViolator
//
//  Created by Taylor Wright-Sanson on 10/15/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
}

- (IBAction)startViolatingPrivacy:(id)sender
{
    [self.locationManager startUpdatingLocation];
    self.textField.text = @"Locating You...";
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Failed: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations) {
        if (location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000) {
            self.textField.text = @"Location Found. Reverse Geocoding...";
            [self reverseGeocode:location];
            NSLog(@"The locations: %@", location);
            [self.locationManager stopUpdatingLocation];
            break;
        }
    }
}

- (void)reverseGeocode: (CLLocation *)location {

}

@end
