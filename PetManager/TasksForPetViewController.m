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
    self.incompleteTasks = [[NSMutableArray alloc]init];
    self.completedTasks = [[NSMutableArray alloc]init];
    
    self.allTasks = self.dao.allTasks;
    
    self.tasksForPetTableView.delegate = self;
    self.tasksForPetTableView.dataSource = self;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTask)];
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wolf-cartoon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goToPetProfile)];
    
    self.navigationItem.rightBarButtonItems = @[addBtn, profileButton];
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return self.dao.allTasks.count;
    if (section == 0)
        return self.incompleteTasks.count;
    if (section == 1)
        return self.completedTasks.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TasksTableViewCell";
    TasksTableViewCell *cell = (TasksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    Task *task = [[Task alloc]init];
//    task = self.dao.allTasks[indexPath.row];
//    
//    cell.taskTableCellTaskName.text = task.taskName;
//    cell.taskTableCellPetName.text = task.taskNote;
//    cell.taskTableCellImage.image = task.loadedImage;
    
    
    
    if (indexPath.section == 0){
        Task *task = [[Task alloc]init];
        task = self.incompleteTasks[indexPath.row];
        
        cell.taskTableCellTaskName.text = task.taskName;
        cell.taskTableCellPetName.text = task.taskNote;
        cell.taskTableCellImage.image = task.loadedImage;
    }
    
    if (indexPath.section == 1){
        Task *task = [[Task alloc]init];
        task = self.completedTasks[indexPath.row];
        
        cell.taskTableCellTaskName.text = task.taskName;
        cell.taskTableCellPetName.text = task.taskNote;
        cell.taskTableCellImage.image = task.loadedImage;
        cell.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:.3];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.taskInfoViewController == nil) {
        self.taskInfoViewController = [[TaskInfoViewController alloc] init];
    }
    
    self.taskInfoViewController.pet = self.pet;
    
    if (indexPath.section == 0){
        self.taskInfoViewController.task = self.incompleteTasks[indexPath.row];
    } else {
        self.taskInfoViewController.task = self.completedTasks[indexPath.row];
    }
    
    [self.navigationController pushViewController:self.taskInfoViewController animated:YES];
    
}

- (void)goToPetProfile {
 
    if (self.profileForPetViewController == nil) {
        self.profileForPetViewController = [[ProfileForPetViewController alloc] init];
    }
    
    self.profileForPetViewController.pet = self.pet;
    
    [self.navigationController pushViewController:self.profileForPetViewController animated:YES];
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

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    [self.incompleteTasks removeAllObjects];
    [self.completedTasks removeAllObjects];
    for (Task *task in self.dao.allTasks){
        if (task.is_task_complete == 0){
            [self.incompleteTasks addObject:task];
        } else {
            [self.completedTasks addObject:task];
        }
    }
    
    if (section == 0 && self.incompleteTasks.count > 0){
        return @"To Do";
    } else if (section == 0 && self.incompleteTasks.count == 0){
        return @"";
    }
    if (section == 1 && self.completedTasks.count > 0){
        return @"Done";
    } else if (section == 1 && self.incompleteTasks.count == 0){
        return @"";
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        
        
        if (indexPath.section == 0){
            Task *task = [self.incompleteTasks objectAtIndex:indexPath.row];
            
            [self.dao deleteTaskWithTaskID:task.taskId];
            
            [[self.dao allTasks]removeObject:task];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView reloadData];
        }
        
        if (indexPath.section == 1){
            Task *task = [self.completedTasks objectAtIndex:indexPath.row];
            
            [self.dao deleteTaskWithTaskID:task.taskId];
            
            [[self.dao allTasks]removeObject:task];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView reloadData];
        }
    }
}



@end
