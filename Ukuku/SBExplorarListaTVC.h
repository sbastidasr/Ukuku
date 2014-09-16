//
//  SBExplorarListaTVC.h
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/16/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SBExplorarListaTVC : PFQueryTableViewController
@property (nonatomic,strong) NSString *clasification;
@property (nonatomic,strong) NSString *region;
@end
