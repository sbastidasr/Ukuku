//
//  JSCreateAnimalVC.m
//  Ukuku
//
//  Created by JuanSe Jativa on 10/09/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "JSCreateSpecieVC.h"
#import "JSChooseTypeTVC.h"
#import "JSCreateNC.h"
#import <Parse/Parse.h>
#import "UIView+BackGround.h"
#import "UITextField+PlaceHolder.h"




@interface JSCreateSpecieVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *clasificationSegmented;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cientificNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

- (IBAction)camerPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)backPressed:(id)sender;


@property (nonatomic, strong)UIImage *newSpecieImage;

@end

@implementation JSCreateSpecieVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViewLook];

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {

    JSCreateNC *nav = (JSCreateNC *)self.navigationController;
    
    NSLog(@"%@", nav.region);
    NSLog(@"%@", nav.risk);
    NSLog(@"%@", nav.type);

}

-(UIImage *)newSpecieImage {

    if (!_newSpecieImage) {
        _newSpecieImage = nil;
    }
    
    return _newSpecieImage;

}

-(void)configureViewLook {
    
    [self configureTextFields];
    [self configureTextView];
    [self configureScroller];
    [self configureNavigationBar];
    [self.view setBackgroundWithImageNamed:@"backGroundLogIn@2x.png"];

}



-(void)configureTextFields {
    
    [self.nameTextField setPlaceholder:@"  Nombre" andTextFieldBackgroundColor:[UIColor whiteColor]];
    [self.cientificNameTextField setPlaceholder:@"  Nombre Cientifico" andTextFieldBackgroundColor:[UIColor whiteColor]];

}


-(void)configureTextView {

    self.descriptionTextView.text = @"Descripcion";
    [self.descriptionTextView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.descriptionTextView.layer setBorderWidth:1.5f];
    self.descriptionTextView.delegate = self;
    

}

-(void)configureScroller {
    
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320, 620)];

}

-(void)configureNavigationBar {
    
    self.title=@"Crear Especie";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - Navigation


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.descriptionTextView endEditing:YES];
    
    if ([segue.identifier isEqualToString:@"pushTypes"]) {
        JSChooseTypeTVC *chooseController = (JSChooseTypeTVC *)segue.destinationViewController;
        chooseController.clasification = self.clasificationSegmented.selectedSegmentIndex;
    }

}

#pragma Mark - OverrideMethods

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        titleView.textColor = [UIColor whiteColor];
        
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (IBAction)camerPressed:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (IBAction)savePressed:(id)sender {
    
    JSCreateNC *nav = (JSCreateNC *)self.navigationController;
    
    if (!_nameTextField.text || !_cientificNameTextField.text || !_descriptionTextView.text || !_newSpecieImage
        || !nav.region || !nav.risk || !nav.type) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Ningun campo puede estar vacio" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show ];
        return;
    }
    else {
        
        [self uploadData];
        
    }
    
}

- (IBAction)backPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadData {
    
    NSData *data = [@"Foto principal de especie" dataUsingEncoding:NSUTF8StringEncoding];
    PFFile *file = [PFFile fileWithName:@"resume.txt" data:data];
    
    PFObject *especie = [PFObject objectWithClassName:@"Especie"];
    especie[@"FloraFauna"] = @"Fauna";
    especie[@"Nombre"] = @"Ocelote";
    especie[@"NombreLatin"] = @"Leopardus pardalis";
    especie[@"Descripcion"] = @"Preocupacion Menor";
    especie[@"Region"] = @"Oriente";
    especie[@"Tipo"] = @"Mamifero";
    especie[@"Status"] = @"En peligro de extincion";
    especie[@"foto"] = file;
    
    NSLog(@"Subiendo a parse");
    
}



#pragma mark - Image picker view controller delegate

- (void) imagePickerController:(UIImagePickerController *)imagePickerController
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.newSpecieImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextViewDelegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Descripcion"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Descripcion";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView resignFirstResponder];
}



@end
