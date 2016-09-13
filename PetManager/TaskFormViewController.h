//
//  TaskFormViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "TasksForPetViewController.h"
@class TasksForPetViewController;

@interface TaskFormViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *petName;

@property (strong, nonatomic) IBOutlet UITextField *taskName;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) IBOutlet UITextField *noteTextField;

@property (strong, nonatomic) IBOutlet UISwitch *recurringSwitch;

@property (strong, nonatomic) Pet *pet;
@property (nonatomic, retain) TasksForPetViewController *tasksForPetViewController;

- (IBAction)saveButton:(id)sender;

@end
