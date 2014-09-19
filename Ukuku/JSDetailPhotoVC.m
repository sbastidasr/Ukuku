//
//  JSDetailPhotoVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 19/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSDetailPhotoVC.h"
#import "GeoPointAnnotation.h"
#import <MapKit/MapKit.h>


@interface JSDetailPhotoVC () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation JSDetailPhotoVC

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
    [self configureLook];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureLook {
    [self configureMapView];
    [self configureImageView];
    self.titleLabel.text = self.species[@"titulo"];

}

-(void)configureImageView {
    
    
    self.imageView.image = self.image;
    
}

-(void)configureMapView {
    
    self.mapView.delegate = self;
    GeoPointAnnotation *geoPointAnnotation = [[GeoPointAnnotation alloc]
                                              initWithObject:self.species];
    [self.mapView addAnnotation:geoPointAnnotation];
    

}


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
