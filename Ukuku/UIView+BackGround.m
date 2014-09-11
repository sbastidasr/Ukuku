//
//  UIView+BackGround.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "UIView+BackGround.h"

@implementation UIView (BackGround)


-(void)setBackgroundWithImaheNamed:(NSString *)name {

    UIGraphicsBeginImageContext(self.frame.size);
    [[UIImage imageNamed:name] drawInRect:self.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.backgroundColor = [UIColor colorWithPatternImage:image];

}

@end
