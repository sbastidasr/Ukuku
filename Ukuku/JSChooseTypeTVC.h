//
//  JSChooseTypeTVC.h
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSInteger {
    Flora = 0,
    Fauna = 1,
} Clasification;

@interface JSChooseTypeTVC : UITableViewController

@property(nonatomic)Clasification clasification;


@end
