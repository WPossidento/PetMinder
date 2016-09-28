//
//  TasksForPetViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "TaskFormViewController.h"
#import "TaskInfoViewController.h"
@class TaskFormViewController;

@interface TasksForPetViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tasksForPetTableView;
@property (strong, nonatomic) Pet *pet;
@property (nonatomic, retain) TaskFormViewController *taskFormViewController;
@property (nonatomic, retain) TaskInfoViewController *taskInfoViewController;

@property (strong, nonatomic) NSMutableArray<Task*> *allTasks;
@property (nonatomic, strong) NSMutableArray<Task*> *incompleteTasks;
@property (nonatomic, strong) NSMutableArray<Task*> *completedTasks;

@end
