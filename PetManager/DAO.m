//
//  DAO.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DAO.h"

@interface DAO ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DAO

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _animalTypes = [[NSMutableArray alloc] init];
        [self createAnimalTypes];
    }
    return self;
}

- (AnimalType *)addAnimalTypeWithName:(NSString *)name andImage:(NSString *)image {
    
    AnimalType *newAnimalType = [[AnimalType alloc] initWithAnimalType:name andImage:image];
    [self.animalTypes addObject:newAnimalType];
    
    return newAnimalType;
}

-(void)createAnimalTypes {
    
    /* AnimalType *dog = */ [self addAnimalTypeWithName:@"Dog" andImage:@"pet-dog"];
    [self addAnimalTypeWithName:@"Cat" andImage:@"cat-img"];
    [self addAnimalTypeWithName:@"Bird" andImage:@"bird-img"];
    [self addAnimalTypeWithName:@"Ferret" andImage:@"ferret-img"];
    [self addAnimalTypeWithName:@"Horse" andImage:@"horse-img"];
    [self addAnimalTypeWithName:@"Fish" andImage:@"fish-img"];
    [self addAnimalTypeWithName:@"Snake" andImage:@"snake-img"];
    [self addAnimalTypeWithName:@"Lizard" andImage:@"lizard-img"];
    [self addAnimalTypeWithName:@"Rabbit" andImage:@"rabbit-img"];
    [self addAnimalTypeWithName:@"Mouse" andImage:@"mouse-img"];
    [self addAnimalTypeWithName:@"Hamster" andImage:@"hamster-img"];
    [self addAnimalTypeWithName:@"Turtle" andImage:@"turtle-img"];
    [self addAnimalTypeWithName:@"Pig" andImage:@"pig-img"];
    [self addAnimalTypeWithName:@"Goat" andImage:@"goat-img"];
    [self addAnimalTypeWithName:@"Rat" andImage:@"rat-img"];
    [self addAnimalTypeWithName:@"Guinea Pig" andImage:@"guinea-pig-img"];
    [self addAnimalTypeWithName:@"Chicken" andImage:@"chicken-img"];
    
}

#pragma mark - Core Data stack


- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "clyff-super-ios-company.PetManager" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PetManager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PetManager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - adding deleting

-(void)createPetWithName:(NSString*)name andImage:(NSString*)image andColor:(NSString*)color andMiscDescription:(NSString*)miscDescription andBirthdate:(NSNumber*)birthdate andSex:(NSString*)sex andAnimalType:(AnimalType*)animalType
{
    
    // Create Company
    NSEntityDescription *entityPet = [NSEntityDescription entityForName:@"Pet" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *pet = [[NSManagedObject alloc] initWithEntity:entityPet insertIntoManagedObjectContext:self.managedObjectContext];
    
    //create pet_id
    int petId;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults integerForKey:@"pet_id"]) {
        [defaults setInteger:1 forKey:@"pet_id"];
        petId = 1;
    } else {
        petId = (int)[defaults integerForKey:@"pet_id"] + 1;
        [defaults setInteger:petId forKey:@"pet_id"];
    }
    NSNumber *number = [[NSNumber alloc]initWithInt:petId];
    [pet setValue:number forKey:@"pet_id"];
    [pet setValue:name forKey:@"name"];
    [pet setValue:image forKey:@"image"];
    [pet setValue:color forKey:@"color"];
    [pet setValue:miscDescription forKey:@"miscDescription"];
    [pet setValue:birthdate forKey:@"birthdate"];
    [pet setValue:sex forKey:@"sex"];
    [pet setValue:animalType forKey:@"animalType"];
    
    
    
    [self saveContext];
}

-(void)createAnimalTypeWithName:(NSString*)name andImage:(NSString*) image

{
    
    NSEntityDescription *entityAnimalType = [NSEntityDescription entityForName:@"AnimalType" inManagedObjectContext:self.managedObjectContext];
    
    NSManagedObject *AnimalType = [[NSManagedObject alloc] initWithEntity:entityAnimalType insertIntoManagedObjectContext:self.managedObjectContext];
    
    
    
    int AnimalTypeId;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults integerForKey:@"id"]) {
        
        [defaults setInteger:1 forKey:@"id"];
        
        AnimalTypeId = 1;
        
        
        
    } else {
        
        AnimalTypeId = (int)[defaults integerForKey:@"id"] + 1;
        
        [defaults setInteger:AnimalTypeId forKey:@"id"];
        
    }
    
    
    
    NSNumber *number = [[NSNumber alloc]initWithInt:AnimalTypeId];
    
    [AnimalType setValue:number forKey:@"id"];
    
    [AnimalType setValue:name forKey:@"name"];
    
    [AnimalType setValue:image forKey:@"image"];
    
    
    
    [self saveContext];
    
}



-(void)createTaskWithName:(NSString*)name andNote:(NSString*)note andTime:(NSDate*)time andPet:(Pet*) pet

{
    
    NSEntityDescription *entityTask = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.managedObjectContext];
    
    NSManagedObject *Task = [[NSManagedObject alloc] initWithEntity:entityTask insertIntoManagedObjectContext:self.managedObjectContext];
    
    
    
    int TaskId;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults integerForKey:@"task_id"]) {
        
        [defaults setInteger:1 forKey:@"task_id"];
        
        TaskId = 1;
        
        
        
    } else {
        
        TaskId = (int)[defaults integerForKey:@"task_id"] + 1;
        
        [defaults setInteger:TaskId forKey:@"task_id"];
        
    }
    
    
    
    NSNumber *number = [[NSNumber alloc]initWithInt:TaskId];
    
    [Task setValue:number forKey:@"task_id"];
    
    [Task setValue:name forKey:@"name"];
    
    [Task setValue:name forKey:@"note"];
    
    [Task setValue:time forKey:@"time"];
    
    [Task setValue:pet forKey:@"pet"];
    
    
    
    [self saveContext];
    
    
    
}

-(void)deletePetWithPetID:(int)pet_id
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"Pet MATCHES '.*'"];
    
    [request setPredicate:p];
    
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"pet_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"Pet"];
    [request setEntity:e];
    NSError *error = nil;
    
    
    //This gets data only from context, not from store
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    for (NSManagedObject *Pet in result){
        
        if ([[Pet valueForKey:@"pet_id"]intValue] == pet_id ) {
            [self.managedObjectContext deleteObject:Pet];
        }
    }
}

-(void)fetchPets
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"pet_id MATCHES '.*'"];
    [request setPredicate:p];
    
    
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"pet_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"Pet"];
    [request setEntity:e];
    NSError *error = nil;
    
    
    //This gets data only from context, not from store
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    [self.allPets removeAllObjects];
    
    for (NSManagedObject *element in result) {
        
        Pet *pet = [[Pet alloc]init];
        pet.petID = (int)[element valueForKey:@"pet_id"];
        pet.name = [element valueForKey:@"name"];
        pet.petImage = [element valueForKey:@"image"];
        pet.color = [element valueForKey:@"color"];
        pet.petDescription = [element valueForKey:@"miscDescription"];
        pet.birthDate = [element valueForKey:@"birthdate"];
        pet.sex = [element valueForKey:@"sex"];
//        pet.tasks = [element valueForKey:@"tasks"];
        
        [self.allPets addObject:pet];
    }
    
    
}


@end
