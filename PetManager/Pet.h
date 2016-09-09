//
//  Pet.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *petImage;
@property int petID;
@property (strong, nonatomic) NSString *animalType;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *petDescription;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSMutableArray *arrayOfTasks;


-(instancetype)initWithPetName:(NSString *)name andPetImage:(NSString *)petImage andAnimalType:(NSString *)animalType andColor:(NSString *)color andPetDescription:(NSString *)petDescription andSex:(NSString *)sex andBirthDate:(NSDate *)birthDate;

@end
