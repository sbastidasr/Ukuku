//
//  JSAllPhotoLocationsVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 18/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSAllPhotoLocationsVC.h"
#import "GeoPointAnnotation.h"
#import <MapKit/MapKit.h>

@interface JSAllPhotoLocationsVC () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation JSAllPhotoLocationsVC

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
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {

    [self updatePhotoLocations];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatePhotoLocations {
    
    PFQuery *query = [PFQuery queryWithClassName:@"PhotoLocation"];
    //[query whereKey:@"specie" equalTo:@"asd"];   asd cuando solo se quiera una especie especifica.
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                PFObject *usuario=object[@"user"];
                
                [usuario fetchIfNeededInBackgroundWithBlock:^(PFObject *usuario, NSError *error) {
                    NSMutableDictionary *profile= usuario[@"profile"];
                    
                    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
                                                              initWithObject:object];
                    geoPointAnnotation.title = (NSString *)[profile objectForKey:@"name"];
                    [self.mapView addAnnotation:geoPointAnnotation];
                    
                }];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
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
