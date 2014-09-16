//
//  SBSpeciesDetailVC.h
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/16/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SBSpeciesDetailVC : UIViewController
@property (nonatomic,strong) PFObject *species;
@end
