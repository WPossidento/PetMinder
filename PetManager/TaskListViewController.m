//
//  TaskListViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskListViewController.h"
#import "TasksTableViewCell.h"
#import "DAO.h"

@interface TaskListViewController ()

@property(strong, nonatomic) DAO *dao;

@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DAO sharedInstance];
    
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
    
    self.title = @"Tasks";
    [self.dao fetchTasks];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dao.allTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TasksTableViewCell";
    TasksTableViewCell *cell = (TasksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Task *task = [[Task alloc]init];
    task = self.dao.allTasks[indexPath.row];
    
    //NSLog(@"%@", self.pet.petImage);
    
    cell.taskTableCellTaskName.text = task.taskName;
    cell.taskTableCellPetName.text = task.taskNote;
    cell.taskTableCellImage.image = task.loadedImage;
    
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
    
    self.taskInfoViewController.pet = self.task.pet;
    self.taskInfoViewController.task = self.allTasks[indexPath.row];
    [self.navigationController pushViewController:self.taskInfoViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end