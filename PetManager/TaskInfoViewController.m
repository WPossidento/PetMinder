//
//  TaskInfoViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/23/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskInfoViewController.h"
#import "DAO.h"
#import "TaskFormViewController.h"

@interface TaskInfoViewController ()

@property (strong, nonatomic) DAO *dao;

@end

@implementation TaskInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dao = [DAO sharedInstance];

    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(editTask)];
    self.navigationItem.rightBarButtonItem = editButton;

    // Do any additional setup after loading the view from its nib.

}

- (void)editTask {

    NSLog (@"Edit Task Chosen");

    TaskFormViewController *tfvc = [[TaskFormViewController alloc]init];
    tfvc.isEditMode = YES;
    tfvc.pet = self.pet;
    tfvc.task = self.task;


    [self.navigationController pushViewController:tfvc animated:YES];

    //    if (self.TaskListViewController == nil) {
    //        self.taskFormViewController = [[TaskFormViewController alloc] init];
    //    }
    //
    //    self.taskFormViewController.pet = self.pet;
    //    self.taskFormViewController.title = @"Edit Task";
    //    [self.navigationController pushViewController:self.taskFormViewController animated:YES];
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

    if (self.task.is_task_complete == YES){
        [self.taskCompleteButton setTitle:@"Task Incomplete" forState:normal];
    } else {
        [self.taskCompleteButton setTitle:@"Task Complete" forState:normal];
    }

    self.taskForPetNameInfo.text = [NSString stringWithFormat:@"Task for %@", self.pet.name];
    self.infoPetImage.image = self.task.loadedImage;

    //    self.infoPetImage.image = self.pet.loadedImage;

    self.infoTaskName.text = [NSString stringWithFormat:@"%@", self.task.taskName];
    self.infoTaskNote.text = [NSString stringWithFormat:@"%@", self.task.taskNote];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy @ h:mm a"];
    NSDate *theDate;
    theDate = self.task.time;

    self.infoTaskDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:theDate]];
}

- (IBAction)taskComplete:(id)sender {
    if (self.task.is_task_complete == NO){
        self.task.is_task_complete = YES;
        
        NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        for(UILocalNotification *notification in notificationArray){
            
            NSString *alertString = [NSString stringWithFormat:@"%@ - %@", self.task.taskName, self.task.pet.name];
            
            if ([notification.alertBody isEqualToString:alertString]  && (notification.fireDate == self.task.time)) {
                // delete this notification
                [[UIApplication sharedApplication] cancelLocalNotification:notification] ;
            }
        }
        
        [self.dao change_is_task_completed_BOOL_in_core_data:self.task];
        
    } else {
        self.task.is_task_complete = NO;
        [self.dao change_is_task_completed_BOOL_in_core_data:self.task];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
