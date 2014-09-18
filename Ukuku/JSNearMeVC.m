//
//  JSNearMeVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 17/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSNearMeVC.h"
#import "GeoPointAnnotation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JSNearMeVC () <CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong)CLLocationManager *locationManager;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;




@end

@implementation JSNearMeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startLocationServices];
    [self configureLook];
    self.mapView.showsUserLocation = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)configureLook {

    [self configureNavigationBar];
    [self.mapView showsUserLocation];
    self.mapView.delegate =self;

}

-(void)configureNavigationBar {
    
    
    
}

-(void)centerMap {

    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    
}

-(void)backButtonPressed:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - Location Services

-(void)startLocationServices {
    
    BOOL enable = [CLLocationManager locationServicesEnabled];
    
    if(enable) {
        
        _locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.distanceFilter=10;
        [self.locationManager startUpdatingLocation];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    [self centerMap];
    
    CLLocation *newLocation = [locations lastObject];
    
    if (newLocation.coordinate.latitude && newLocation.coordinate.longitude) {
        [self updateLocations];
    }

}

- (void)updateLocations {

    
    PFQuery *query = [PFQuery queryWithClassName:@"PhotoLocation"];
    [query setLimit:1000];
    [query whereKey:@"location"
       nearGeoPoint:[PFGeoPoint geoPointWithLatitude:self.locationManager.location.coordinate.latitude
                                           longitude:self.locationManager.location.coordinate.longitude]
   withinKilometers:15];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
                                                          initWithObject:object];
                [self.mapView addAnnotation:geoPointAnnotation];
            }
        }
    }];
}

#pragma MapView Delegate


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[GeoPointAnnotation class]]) {
        
        GeoPointAnnotation *myLocation = (GeoPointAnnotation *)annotation;
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        
        if (annotationView==nil)
            annotationView = myLocation.annotationView;
         else
            annotationView.annotation=annotation;
        
        return annotationView;
            
        
    }
    else
        return nil;

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
