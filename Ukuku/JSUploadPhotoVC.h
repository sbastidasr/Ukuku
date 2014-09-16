//
//  JSUploadPhotoVC.h
//  Ukuku
//
//  Created by JuanSe Jativa on 16/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JSUploadPhotoVC : UIViewController

@property(nonatomic, strong)UIImage *photoTaked;
@property(nonatomic) CLLocationCoordinate2D photoCoordinate;

@end
