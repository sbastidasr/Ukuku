//
//  SBNewsCellNuevo.h
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SBNewsCellNuevo : UITableViewCell


@property (strong, nonatomic) NSString *photoTitleProperty;
@property (strong, nonatomic)  NSString *speciesNameProperty;
@property (strong, nonatomic)  NSString *userNameProperty;
@property (strong, nonatomic)  NSString *locationStringProperty;
@property (strong, nonatomic) UIImage  *userImageProperty;
@property (strong, nonatomic)  UIImage *speciesImageProperty;


-(void)cleanCell;
-(void)configureCell;

@end
