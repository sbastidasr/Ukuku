//
//  JSDetailPhotoVC.h
//  Ukuku
//
//  Created by JuanSe Jativa on 19/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JSDetailPhotoVC : UIViewController

@property(nonatomic, strong) PFObject *species;
@property(nonatomic, strong) UIImage *image;

@end
