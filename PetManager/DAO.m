//
//  DAO.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DAO.h"
#import "ManagedPet.h"
#import "ManagedTask.h"
#import "ManagedAnimalType.h"
#import "Pet.h"
#import "AnimalType.h"
#import "Task.h"


@interface DAO ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSMutableArray<ManagedPet*> *managedPets;

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
        _allPets = [[NSMutableArray alloc]init];
        _allTasks = [[NSMutableArray alloc]init];
        
        [self loadAllAnimalType];
        
        
   //     [self createAnimalTypes];
    }
    return self;
}

- (AnimalType *)addAnimalTypeWithName:(NSString *)name andImage:(NSString *)image {
    
    AnimalType *newAnimalType = [[AnimalType alloc] initWithAnimalType:name andImage:image];
    [self createAnimalTypeWithName:name andImage:image];
    [self.animalTypes addObject:newAnimalType];
    
    return newAnimalType;
}

-(void)createAnimalTypes {
    
    /* AnimalType *dog = */ [self addAnimalTypeWithName:@"Dog" andImage:@"dog-img"];
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

- (void)loadAllAnimalType {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedAnimalType"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    } else if (result.count==0) {
        [self createAnimalTypes];
    } else {
        for (ManagedAnimalType *mat in result) {
            AnimalType *at = [[AnimalType alloc] initWithAnimalType:mat.name andImage:mat.image];
            at.animalType_id = [mat.animalType_id intValue];
            [self.animalTypes addObject:at];
        }
    }
}

- (void)loadAllPets {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedPet"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    } else {
        
        self.allPets = [[NSMutableArray alloc]init];
        
        for (ManagedPet *mp in result) {
//            NSLog(@"%@ %@",  [mp.animalType animalType_id], [mp.animalType name]);
            
            Pet *pet = [[Pet alloc] initWithPetName:mp.name andPetImage:mp.image andAnimalType:nil andColor:mp.color andPetDescription:mp.miscDescription andSex:mp.sex andBirthDate:mp.birthdate];
            //pet.petID = (int)mp.pet_id;
            NSNumber *number = [[NSNumber alloc]init];
            number = mp.pet_id;
            long hi = [number longValue];
            pet.petID = (int)hi;
            
            NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir  = [documentPaths objectAtIndex:0];
            NSString *imgPath    = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_id_%d.png", pet.petID]];
            
//            NSFileManager *fileManager = [[NSFileManager alloc] init];
//            if ([fileManager fileExistsAtPath:imgPath]) {
//                NSLog(@"FOUND IMG");
//                NSLog(@"%@", imgPath);
//            }
            
            NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
            pet.loadedImage = [[UIImage alloc] initWithData:imgData];
            
            [self.allPets addObject:pet];
        }
    }
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
    NSLog(@"%@", storeURL);

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

-(Pet*)createPetWithName:(NSString*)name andImage:(NSString*)image andColor:(NSString*)color andMiscDescription:(NSString*)miscDescription andBirthdate:(NSDate*)birthdate andSex:(NSString*)sex andAnimalType:(AnimalType*)animalType
{
    // Create Pet
    NSEntityDescription *entityPet = [NSEntityDescription entityForName:@"ManagedPet" inManagedObjectContext:self.managedObjectContext];
    
    Pet *newPet = [[Pet alloc] initWithPetName:name andPetImage:image andAnimalType:animalType andColor:color andPetDescription:miscDescription andSex:sex andBirthDate:birthdate];
    [self.allPets addObject:newPet];
    ManagedPet *petMO = [[ManagedPet alloc] initWithEntity:entityPet insertIntoManagedObjectContext:self.managedObjectContext];
    petMO.name = newPet.name;
    petMO.image = newPet.petImage;
    petMO.color = newPet.color;
    petMO.miscDescription = newPet.petDescription;
    petMO.birthdate = newPet.birthDate;
    petMO.sex = newPet.sex;
    
//    [petMO setValue:image forKey:@"image"];
//    [petMO setValue:color forKey:@"color"];
//    [petMO setValue:miscDescription forKey:@"miscDescription"];
//    [petMO setValue:birthdate forKey:@"birthdate"];
//    [petMO setValue:sex forKey:@"sex"];
    
    //Fetch an animal type with animalTypeId
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"animalType_id == %d", animalType.animalType_id];
    [request setPredicate:p];
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedAnimalType"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(error){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if(result.count >= 1){
        ManagedAnimalType *mat = [result objectAtIndex:0];
        petMO.animalType = mat;
    }

    //create pet_id
//    int petId;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults integerForKey:@"pet_id"]) {
        [defaults setInteger:1 forKey:@"pet_id"];
        newPet.petID = 1;
//        petId = 1;
    } else {
        newPet.petID = (int)[defaults integerForKey:@"pet_id"] + 1;
        [defaults setInteger:newPet.petID forKey:@"pet_id"];
    }
    NSNumber *number = [[NSNumber alloc]initWithInt:newPet.petID];
//    [petMO setValue:number forKey:@"pet_id"];
    petMO.pet_id = number;

    
    [self saveContext];
    
    return newPet;
}

-(void)createAnimalTypeWithName:(NSString*)name andImage:(NSString*) image

{
    
    NSEntityDescription *entityAnimalType = [NSEntityDescription entityForName:@"ManagedAnimalType" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *AnimalType = [[NSManagedObject alloc] initWithEntity:entityAnimalType insertIntoManagedObjectContext:self.managedObjectContext];

    int animalType_id;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults integerForKey:@"animalType_id"]) {
        [defaults setInteger:1 forKey:@"animalType_id"];
        animalType_id = 1;
    } else {
        animalType_id = (int)[defaults integerForKey:@"animalType_id"] + 1;
        [defaults setInteger:animalType_id forKey:@"animalType_id"];
    }
    
    NSNumber *number = [[NSNumber alloc]initWithInt:animalType_id];
    [AnimalType setValue:number forKey:@"animalType_id"];
    [AnimalType setValue:name forKey:@"name"];
    [AnimalType setValue:image forKey:@"image"];
    
    [self saveContext];
    
}



-(Task*)createTaskWithName:(NSString*)name andNote:(NSString*)note andTime:(NSDate*)time andPet:(Pet*) pet

{
    NSEntityDescription *entityTask = [NSEntityDescription entityForName:@"ManagedTask" inManagedObjectContext:self.managedObjectContext];
    
    Task *newTask = [[Task alloc] initWithTaskName:name andPetId:pet.petID andTaskNote:note];
    [self.allTasks addObject:newTask];
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
    [Task setValue:note forKey:@"note"];
    [Task setValue:time forKey:@"time"];
    //    [Task setValue:pet forKey:@"pet"];
    
    //Fetch a pet with petId
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"pet_id == %d", pet.petID];
    [request setPredicate:p];
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedPet"];
    [request setEntity:e];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(error){
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    } else if(result.count >= 1){
        ManagedPet *mat = [result objectAtIndex:0];
        [Task setValue:mat forKey:@"pet"];
    }
    
    
    [self saveContext];
    
    return newTask;
}


-(void)deletePetWithPetID:(int)pet_id
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"pet_id = %d", pet_id];
    
    [request setPredicate:p];
    
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"pet_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedPet"];
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
    
    [self saveContext];
}

-(void)deleteTaskWithTaskID:(int)task_id

{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"task_id = %d", task_id];
    
    [request setPredicate:p];
    
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   
                                   initWithKey:@"task_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedTask"];
    
    [request setEntity:e];
    
    NSError *error = nil;
    
    //This gets data only from context, not from store
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
        
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    for (NSManagedObject *Task in result){
        if ([[Task valueForKey:@"task_id"]intValue] == task_id ) {
            [self.managedObjectContext deleteObject:Task];
        }
    }
    
    [self saveContext];
    
}

-(void)deleteAnimalTypeWithID:(int)animalType_id

{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"animalType_id = %d", animalType_id];
    
    [request setPredicate:p];
    
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   
                                   initWithKey:@"animalType_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedAnimalType"];
    
    [request setEntity:e];
    
    NSError *error = nil;
    
    //This gets data only from context, not from store
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
        
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    for (NSManagedObject *animalType in result){
        if ([[animalType valueForKey:@"animalType_id"]intValue] == animalType_id ) {
            [self.managedObjectContext deleteObject:animalType];
        }
    }
    
    [self saveContext];
    
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
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedPet"];
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

-(void)fetchTasks
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"time MATCHES '.*'"];
    [request setPredicate:p];
    
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"time" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedTask"];
    [request setEntity:e];
    NSError *error = nil;
    
    
    //This gets data only from context, not from store
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    [self.allTasks removeAllObjects];
    
    for (NSManagedObject *element in result) {
        
        ManagedPet *managedPet = [element valueForKey:@"pet"];
        
        NSNumber *number = [[NSNumber alloc]init];
        long longToInt;
        
        Task *task = [[Task alloc]init];
        number = [element valueForKey:@"task_id"];
        longToInt = [number longValue];
        task.taskId = (int)longToInt;
        task.taskName = [element valueForKey:@"name"];
        task.taskNote = [element valueForKey:@"note"];
        //        ManagedPet *pet = [[ManagedPet alloc]init];
        //        pet = [element valueForKey:@"color"];
        task.time = [element valueForKey:@"time"];
        
        Pet *pet = [[Pet alloc]init];
        pet.petImage = managedPet.image;
        pet.name = managedPet.name;
        pet.color = managedPet.color;
        pet.petDescription = managedPet.miscDescription;
        pet.sex = managedPet.sex;
        pet.birthDate = managedPet.birthdate;
        
        task.pet = pet;
        
        number = managedPet.pet_id;
        longToInt = [number longValue];
        task.petId = (int)longToInt;
        
        NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir  = [documentPaths objectAtIndex:0];
        NSString *imgPath    = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_id_%d.png", pet.petID]];
        
        //            NSFileManager *fileManager = [[NSFileManager alloc] init];
        //            if ([fileManager fileExistsAtPath:imgPath]) {
        //                NSLog(@"FOUND IMG");
        //                NSLog(@"%@", imgPath);
        //            }
        
        NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
        task.loadedImage = [[UIImage alloc] initWithData:imgData];
        
        [self.allTasks addObject:task];
    }
}

-(void)fetchTasksForSpecificPet:(Pet*)pet
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"task_id MATCHES '.*'"];
    [request setPredicate:p];
    //
    
    
    //Change ascending  YES/NO and validate
    NSSortDescriptor *sortByKey = [[NSSortDescriptor alloc]
                                   initWithKey:@"task_id" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByKey]];
    
    
    
    NSEntityDescription *e = [[self.managedObjectModel entitiesByName] objectForKey:@"ManagedTask"];
    [request setEntity:e];
    NSError *error = nil;
    
    
    
    
    //This gets data only from context, not from store
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!result)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    [self.allTasks removeAllObjects];
    
    
    
    for (NSManagedObject *element in result) {
        
        ManagedPet *managedPet = [element valueForKey:@"pet"];
        
        NSNumber *number = [[NSNumber alloc]init];
        number = managedPet.pet_id;
        long hi = [number longValue];
        
        if (pet.petID == (int)hi){
            Task *task = [[Task alloc]init];
            number = [element valueForKey:@"task_id"];
            hi = [number longValue];
            task.taskId = (int)hi;
            task.petId = pet.petID;
            task.taskName = [element valueForKey:@"name"];
            task.taskNote = [element valueForKey:@"note"];
            task.time = [element valueForKey:@"time"];
            
            NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir  = [documentPaths objectAtIndex:0];
            NSString *imgPath    = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_id_%@.png", managedPet.pet_id]];
            
            //            NSFileManager *fileManager = [[NSFileManager alloc] init];
            //            if ([fileManager fileExistsAtPath:imgPath]) {
            //                NSLog(@"FOUND IMG");
            //                NSLog(@"%@", imgPath);
            //            }
            
            NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
            task.loadedImage = [[UIImage alloc] initWithData:imgData];
            
            [self.allTasks addObject:task];
        }
    }
}



@end
