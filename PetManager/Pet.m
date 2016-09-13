//
//  Pet.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "Pet.h"

@implementation Pet

-(instancetype)initWithPetName:(NSString *)name andPetImage:(NSString *)petImage andAnimalType:(AnimalType *)animalType andColor:(NSString *)color andPetDescription:(NSString *)petDescription andSex:(NSString *)sex andBirthDate:(NSDate *)birthDate {
    
    self = [super init];
    if (self) {
        _name = name;
        _petImage = petImage;
        _animalType = animalType;
        _color = color;
        _petDescription = petDescription;
        _sex = sex;
        _birthDate = birthDate;
//        _arrayOfTasks = arrayOfTasks;
        return self;
    }
    
    return nil;
 
    
    
    
}

@end
