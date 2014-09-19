//
//  SBNewsCellNuevo.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBNewsCellNuevo.h"

@interface SBNewsCellNuevo()

@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (weak, nonatomic) IBOutlet UILabel *speciesName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *locationString;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *speciesImage;

@end

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
    self.photoTitle.text=self.photoTitleProperty;
    self.speciesName.text=self.speciesNameProperty;
    self.userName.text=self.userNameProperty;
    self.locationString.text=self.locationStringProperty;
    self.userImage.image=self.userImageProperty;
    self.speciesImage.image=self.speciesImageProperty;
    

    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
  //  [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    NSLog(@"@%",self.userId);
}

-(void)cleanCell{
    self.photoTitle.text=nil;
    self.speciesName.text=nil;
    self.userName.text=nil;
    self.locationString.text=nil;
    self.userImage.image=nil;
    self.speciesImage.image=nil;
}


@end
