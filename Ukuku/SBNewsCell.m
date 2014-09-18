//
//  SBNewsCell.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/18/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "SBNewsCell.h"
@interface SBNewsCell()
@property (weak, nonatomic) IBOutlet UIView *speciesImage;

@end

@implementation SBNewsCell

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

    //le asigno a los outelses

}

-(void)cleanCell{
//todos los outlets a nil
    //labels tb
    self.speciesImage=nil;

}
@end
