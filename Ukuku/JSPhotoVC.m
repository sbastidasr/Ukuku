//
//  JSPhotoVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 16/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSPhotoVC.h"
#import "JSUploadPhotoVC.h"
#import <CoreLocation/CoreLocation.h>

@interface JSPhotoVC () <UIPickerViewDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong)UIImage *animalPic;
@property(nonatomic, strong)CLLocationManager *locationManager;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation JSPhotoVC

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
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {

    [self openCamera];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)animalPic {

    if (!_animalPic) {
        _animalPic=nil;
    }
    
    return _animalPic;

}

-(void)openCamera {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.coordinate  = self.locationManager.location.coordinate;
        
    } else {
    
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];

}

#pragma mark - Image picker view controller delegate

- (void) imagePickerController:(UIImagePickerController *)imagePickerController
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.tabBarController setSelectedIndex:0];
    self.animalPic = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:NO completion:nil];
    JSUploadPhotoVC *newController = [[JSUploadPhotoVC alloc] init];
    newController.photoCoordinate = self.locationManager.location.coordinate;
    newController.photoTaked = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self presentViewController:newController animated:YES completion:nil];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
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

@end
