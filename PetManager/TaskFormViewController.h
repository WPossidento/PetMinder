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
#import "Task.h"
#import "TaskInfoViewController.h"

@class TasksForPetViewController;

@interface TaskFormViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *petName;
@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *noteTextField;
@property (strong, nonatomic) IBOutlet UISwitch *recurringSwitch;
@property (strong, nonatomic) IBOutlet UILabel *recurringLabel;
@property (nonatomic) BOOL isEditMode;

@property (strong, nonatomic) Pet *pet;
@property (nonatomic, retain) TasksForPetViewController *tasksForPetViewController;
@property (strong, nonatomic) Task *task;

- (IBAction)saveButton:(id)sender;

@end
