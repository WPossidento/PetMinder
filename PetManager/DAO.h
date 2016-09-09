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
@property (nonatomic, retain) NSMutableArray *allPets;
@property (nonatomic, retain) NSMutableArray *allTasks;

+ (instancetype)sharedInstance;

- (AnimalType *)addAnimalTypeWithName:(NSString *)name andImage:(NSString *)image;

@end
