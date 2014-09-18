//
//  GeoPointAnnotation.m
//  Geolocations
//
//  
//

#import "GeoPointAnnotation.h"

@interface GeoPointAnnotation()
@property (nonatomic, strong) PFObject *object;
@end

@implementation GeoPointAnnotation


#pragma mark - Initialization

- (id)initWithObject:(PFObject *)aObject {
    self = [super init];
    if (self) {
        _object = aObject;
        
        PFGeoPoint *geoPoint = self.object[@"location"];
        [self setGeoPoint:geoPoint];
    }
    return self;
}



#pragma mark - ()

- (void)setGeoPoint:(PFGeoPoint *)geoPoint {
    _coordinate = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    }
    
    static NSNumberFormatter *numberFormatter = nil;
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 3;
    }
    
    _title = [dateFormatter stringFromDate:self.object.updatedAt];
    _subtitle = [NSString stringWithFormat:@"%@", self.object[@"titulo"]];
    
}

-(MKAnnotationView *)annotationView {

    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"CustomAnnotation"];
    PFFile *imageFile = self.object[@"imageFile"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        annotationView.rightCalloutAccessoryView = [[UIImageView alloc] initWithImage:
                                                    [UIImage imageWithCGImage:[image CGImage]
                                                                        scale:(image.scale * 25.0)
                                                                  orientation:(image.imageOrientation)]];
    }];
    
    
    annotationView.enabled=YES;
    annotationView.image = [UIImage imageNamed:@"pingreen.png"];
    annotationView.canShowCallout = YES;
    
    return annotationView;
    

}

@end
