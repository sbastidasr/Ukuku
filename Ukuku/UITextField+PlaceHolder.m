//
//  UITextField+PlaceHolder.m
//  Ukuku
//
//  Created by JuanSe Jativa on 04/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "UITextField+PlaceHolder.h"

@implementation UITextField (PlaceHolder)


-(void)setPlaceholder:(NSString *)placeholder andTextFieldBackgroundColor:(UIColor *) color {

    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        

        [self setBackgroundColor:[UIColor clearColor]];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
       
    } else {

        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
         [self setBackgroundColor:[UIColor whiteColor]];
    
    }
}

@end
