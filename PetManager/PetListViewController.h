//
//  PetListViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalType.h"
#import "AnimalTypeViewController.h"
#import "TasksForPetViewController.h"
@class TasksForPetViewController;

@class AnimalTypeViewController;

@interface PetListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *petListTableView;
@property (nonatomic, retain) AnimalTypeViewController *animalTypeViewController;
@property (nonatomic, retain) NSMutableArray<Pet*> *allPets;
@property (nonatomic, retain) TasksForPetViewController *tasksForPetViewController;

- (IBAction)addPetButton:(id)sender;

@end
