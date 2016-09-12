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

@interface TasksForPetViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tasksForPetTableView;
@property (strong, nonatomic) Pet *pet;
@property (nonatomic, retain) TaskFormViewController *taskFormViewController;

@end
