//
//  JSCreateAnimalVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSCreateAnimalVC.h"

@interface JSCreateAnimalVC ()

@end

@implementation JSCreateAnimalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSMutableDictionary *)optionSelected {

    if (!_optionSelected) {
        _optionSelected = [[NSMutableDictionary alloc] init];
    }
    
    return _optionSelected;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Crear Animal";
    [self imprimirOpciones];
    // Do any additional setup after loading the view.
}

-(void)imprimirOpciones {
    
     NSLog(@"Opciones");

    for (NSString * key in self.optionSelected) {
       
        NSLog(@"%@ : %@", key, [self.optionSelected objectForKey:key] );
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
