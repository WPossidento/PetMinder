//
//  ManagedAnimalType+CoreDataProperties.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedAnimalType.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedAnimalType (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) ManagedPet *pet;

@end

NS_ASSUME_NONNULL_END
