//
//  ManagedTask+CoreDataProperties.h
//  PetManager
//
//  Created by Olivia Taylor on 9/12/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedTask (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSNumber *task_id;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) ManagedPet *pet;

@end

NS_ASSUME_NONNULL_END
