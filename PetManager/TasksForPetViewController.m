//
//  TasksForPetViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TasksForPetViewController.h"

@interface TasksForPetViewController ()

@end

@implementation TasksForPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addNewTask {
    
    if (self.taskFormViewController == nil) {
        self.taskFormViewController = [[TaskFormViewController alloc] init];
    }
    
    self.taskFormViewController.title = @"Add New Task";
    [self.navigationController pushViewController:self.taskFormViewController animated:YES];

}


@end
