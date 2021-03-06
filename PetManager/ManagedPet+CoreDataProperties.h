//
//  ManagedPet+CoreDataProperties.h
//  PetManager
//
//  Created by Olivia Taylor on 9/12/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedPet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedPet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthdate;
@property (nullable, nonatomic, retain) NSString *color;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *miscDescription;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *pet_id;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) ManagedAnimalType *animalType;
@property (nullable, nonatomic, retain) NSSet<ManagedTask *> *tasks;

@end

@interface ManagedPet (CoreDataGeneratedAccessors)

- (void)addTasksObject:(ManagedTask *)value;
- (void)removeTasksObject:(ManagedTask *)value;
- (void)addTasks:(NSSet<ManagedTask *> *)values;
- (void)removeTasks:(NSSet<ManagedTask *> *)values;

@end

NS_ASSUME_NONNULL_END
