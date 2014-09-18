//
//  SBNewsCellNuevo.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBNewsCellNuevo.h"

@implementation SBNewsCellNuevo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureCell {
    
    PFFile * speciesPic=self.especie[@"foto"];
    [speciesPic getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
   //     self.photoLocationPhotoOutlet.image=[UIImage imageWithData:data];
    }];
    
    
    [self.usuario fetchIfNeededInBackgroundWithBlock:^(PFObject *usuario, NSError *error) {
        
        NSMutableDictionary *profile= usuario[@"profile"];
   //     self.userNameOutlet.text=[profile objectForKey:@"name"];
        
        
        PFFile * userPic;//hacer el query para sacar la foto del usuario
        [userPic getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
       //     self.userPhotoOutlet.image=[UIImage imageWithData:data];
        }];
        
    }];
    
  //  self.photoLocationTitleoutlet.text=self.especie[@"titulo"];
 //   self.speciesName.text=self.especie[@"Nombre"];
    
    // self.locationNameOutlet=;el miji debe traer el string del location.
}

-(void)cleanCell{
    //todos los outlets a nil
    //labels tb
 //   self.photoLocationTitleoutlet=nil;
    
}

@end
