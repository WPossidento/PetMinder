//
//  ManagedAnimalType+CoreDataProperties.h
//  PetManager
//
//  Created by Olivia Taylor on 9/12/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedAnimalType.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedAnimalType (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *animalType_id;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<ManagedPet *> *pets;

@end

@interface ManagedAnimalType (CoreDataGeneratedAccessors)

- (void)addPetsObject:(ManagedPet *)value;
- (void)removePetsObject:(ManagedPet *)value;
- (void)addPets:(NSSet<ManagedPet *> *)values;
- (void)removePets:(NSSet<ManagedPet *> *)values;

@end

NS_ASSUME_NONNULL_END
