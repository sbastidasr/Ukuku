//
//  UITableViewController+TitleColor.m
//  Ukuku
//
//  Created by JuanSe Jativa on 15/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "UITableViewController+TitleColor.h"

@implementation UITableViewController (TitleColor)


- (void)setTitleColor:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

@end
