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

@property (nonatomic,strong) PFObject *usuario;
@property (nonatomic,strong) PFObject *especie;

-(void)cleanCell;
-(void)configureCell;

@end
