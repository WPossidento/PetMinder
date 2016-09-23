//
//  DAO.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Pet.h"
#import "AnimalType.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray<AnimalType*> *animalTypes;
@property (nonatomic, retain) NSMutableArray<Pet*> *allPets;
@property (nonatomic, retain) NSMutableArray<Task*> *allTasks;

+ (instancetype)sharedInstance;

- (AnimalType *)addAnimalTypeWithName:(NSString *)name andImage:(NSString *)image;
-(Pet*)createPetWithName:(NSString*)name andImage:(NSString*)image andColor:(NSString*)color andMiscDescription:(NSString*)miscDescription andBirthdate:(NSDate*)birthdate andSex:(NSString*)sex andAnimalType:(AnimalType*)animalType;
- (void)loadAllPets;
-(Task*)createTaskWithName:(NSString*)name andNote:(NSString*)note andTime:(NSDate*)time andPet:(Pet*) pet;
-(void)fetchTasksForSpecificPet:(Pet*)pet;
-(void)fetchPets;
-(void)fetchTasks;


@end
