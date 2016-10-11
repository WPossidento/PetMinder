//
//  TaskListViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskListViewController.h"
#import "TasksTableViewCell.h"
#import "TaskFormViewController.h"
#import "DAO.h"

@interface TaskListViewController ()

@property(strong, nonatomic) DAO *dao;
@property(strong, nonatomic) UILabel *simpleGuidePhraseIfNoTasks;

@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00 green:0.65 blue:1.00 alpha:1.0];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    self.tabBarItem.image = [[UIImage imageNamed:@"text-list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.dao = [DAO sharedInstance];
    self.incompleteTasks = [[NSMutableArray alloc]init];
    self.completedTasks = [[NSMutableArray alloc]init];
    
    self.allTasks = self.dao.allTasks;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
       
    // Do any additional setup after loading the view from its nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.dao fetchTasks];
    
    self.simpleGuidePhraseIfNoTasks = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 70)];
    self.simpleGuidePhraseIfNoTasks.textAlignment = NSTextAlignmentCenter;
    [self.simpleGuidePhraseIfNoTasks sizeToFit];
    self.simpleGuidePhraseIfNoTasks.numberOfLines = 2;
    [self.view addSubview:self.simpleGuidePhraseIfNoTasks];
    CGRect myFrame = CGRectMake(0, 0, 300, 70);
    self.simpleGuidePhraseIfNoTasks.bounds = myFrame;
    self.simpleGuidePhraseIfNoTasks.center = self.view.center;
    
    if (self.dao.allTasks.count == 0){
        self.simpleGuidePhraseIfNoTasks.text = @"Click on a specific pet and click + to add task";
    } else {
        self.simpleGuidePhraseIfNoTasks.text = @"";
    }
    
    self.title = @"Tasks";
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.simpleGuidePhraseIfNoTasks.text = @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return self.dao.allTasks.count;
    if (section == 0)
        return self.incompleteTasks.count;
    if (section == 1)
        return self.completedTasks.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TasksTableViewCell";
    TasksTableViewCell *cell = (TasksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //    Task *task = [[Task alloc]init];
    //    task = self.dao.allTasks[indexPath.row];
    //
    //    //NSLog(@"%@", self.pet.petImage);
    //
    //    cell.taskTableCellTaskName.text = task.taskName;
    //    cell.taskTableCellPetName.text = task.pet.name;
    //    cell.taskTableCellImage.image = task.loadedImage;
    
    if (indexPath.section == 0){
        Task *task = [[Task alloc]init];
        task = self.incompleteTasks[indexPath.row];
        
        cell.taskTableCellTaskName.text = task.taskName;
        cell.taskTableCellPetName.text = task.pet.name;
        cell.taskTableCellImage.image = task.loadedImage;
    }
    
    if (indexPath.section == 1){
        Task *task = [[Task alloc]init];
        task = self.completedTasks[indexPath.row];
        
        cell.taskTableCellTaskName.text = task.taskName;
        cell.taskTableCellPetName.text = task.pet.name;
        cell.taskTableCellImage.image = task.loadedImage;
        cell.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:.3];
    }
    
    
    //    cell.taskTableCellTaskName.text = [NSString stringWithFormat:@"%@", [self.taskList objectAtIndex:[indexPath row]] taskName];
    
    //    cell.cellCompanyName.text = [NSString stringWithFormat:@"%@ (%@)", [[self.companyList objectAtIndex:[indexPath row]] companyName], [[self.companyList objectAtIndex:[indexPath row]] stockSymbol]];
    //    cell.cellCompanyStockPrice.text = [NSString stringWithFormat:@"$%@", [[self.companyList objectAtIndex:[indexPath row]] stockPrice]];
    //    cell.cellCompanyLogo.image = logoImage;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.taskInfoViewController == nil) {
        self.taskInfoViewController = [[TaskInfoViewController alloc] init];
    }
    
    if (indexPath.section == 0){
        Task *task = [[Task alloc] init];
        task = self.incompleteTasks[indexPath.row];
        self.task = task;
    } else {
        Task *task = [[Task alloc] init];
        task = self.completedTasks[indexPath.row];
        self.task = task;
    }
    
    self.taskInfoViewController.task = self.task;
    //    self.taskInfoViewController.task = self.allTasks[indexPath.row];
    self.taskInfoViewController.pet = self.task.pet;
    //    self.taskInfoViewController.infoPetImage.image = task.loadedImage;
    
    [self.navigationController pushViewController:self.taskInfoViewController animated:YES];
    
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
    
    if (self.dao.allTasks.count == 0){
        self.simpleGuidePhraseIfNoTasks.text = @"Click on a specific pet and click + to add task";
    } else {
        self.simpleGuidePhraseIfNoTasks.text = @"";
    }
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

@end