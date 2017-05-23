//
//  ViewController.m
//  Objectivity
//
//  Created by Axel on 05/04/2017.
//  Copyright © 2017 IMERIR. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@property (strong) CLLocationManager* locationMgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationMgr = [[CLLocationManager alloc] init];
    
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationMgr requestWhenInUseAuthorization];
    }
    
    
    self.locationMgr.delegate = self;
    [self.locationMgr startUpdatingLocation];
}

- (void) dealloc {
    self.locationMgr = nil;
}

- (void)locationManager

@end
