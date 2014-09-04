//
//  testClass.m
//  Ukuku
//
//  Created by Sebastian Bastidas on 9/4/14.
//  Copyright (c) 2014 JuanSe Jativa. All rights reserved.
//

#import "testClass.h"
#import <Parse/Parse.h>

@implementation testClass


-(void)testClassinit{
    NSLog(@"AJA");
    
  //creacion de una nueva especie
  
    //Crear la foto.
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
    
    [especie saveInBackground];
    
    /*
     fotos
    -flora/fauna
    -Nombre
    -NombreLatin
    -Descripcion
    -Region [costa/sierra etc]
    -Tipo [pajaro/mamifero] o [planta1/plata2]
    -status [en peligro/extinto]
     */
}
@end
