//
//  UIImage+Crop.h
//  Ukuku
//
//  Created by JuanSe Jativa on 06/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

- (UIImage *) imageSquaredWithSide:(CGFloat)side;
- (UIImage *) imageCropWithWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
