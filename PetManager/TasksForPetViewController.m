//
//  TasksForPetViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TasksForPetViewController.h"
#import "DAO.h"
#import "TasksTableViewCell.h"

@interface TasksForPetViewController ()

@property(strong, nonatomic) DAO *dao;

@end

@implementation TasksForPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DAO sharedInstance];
    
    self.allTasks = self.dao.allTasks;
    
    self.tasksForPetTableView.delegate = self;
    self.tasksForPetTableView.dataSource = self;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.dao fetchTasksForSpecificPet:self.pet];
    [self.tasksForPetTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dao.allTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TasksTableViewCell";
    TasksTableViewCell *cell = (TasksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Task *task = [[Task alloc]init];
    task = self.dao.allTasks[indexPath.row];
    
    NSLog(@"%@", self.pet.petImage);
    
    cell.taskTableCellTaskName.text = task.taskName;
    cell.taskTableCellPetName.text = task.taskNote;
    cell.taskTableCellImage.image = task.loadedImage;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.taskInfoViewController == nil) {
        self.taskInfoViewController = [[TaskInfoViewController alloc] init];
    }
    
    self.taskInfoViewController.pet = self.pet;
    self.taskInfoViewController.task = self.allTasks[indexPath.row];
    [self.navigationController pushViewController:self.taskInfoViewController animated:YES];
    
}

- (void)addNewTask {
    
    if (self.taskFormViewController == nil) {
        self.taskFormViewController = [[TaskFormViewController alloc] init];
    }
    
    self.taskFormViewController.pet = self.pet;
    self.taskFormViewController.title = @"Add New Task";
    [self.navigationController pushViewController:self.taskFormViewController animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



@end
