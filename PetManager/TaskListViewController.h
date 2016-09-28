//
//  TaskListViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskInfoViewController.h"

@interface TaskListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *taskList;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) TaskInfoViewController *taskInfoViewController;
@property (nonatomic, retain) Task *task;
@property (nonatomic, strong) NSMutableArray<Task*> *allTasks;
@property (nonatomic, strong) NSMutableArray<Task*> *incompleteTasks;
@property (nonatomic, strong) NSMutableArray<Task*> *completedTasks;



@end