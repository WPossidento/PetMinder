//
//  TaskListViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskListViewController.h"
#import "TasksTableViewCell.h"

@interface TaskListViewController ()

@end

@implementation TaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TasksTableViewCell";
    TasksTableViewCell *cell = (TasksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
//    cell.taskTableCellTaskName.text = [NSString stringWithFormat:@"%@", [self.taskList objectAtIndex:[indexPath row]] taskName];
    

//    cell.cellCompanyName.text = [NSString stringWithFormat:@"%@ (%@)", [[self.companyList objectAtIndex:[indexPath row]] companyName], [[self.companyList objectAtIndex:[indexPath row]] stockSymbol]];
//    cell.cellCompanyStockPrice.text = [NSString stringWithFormat:@"$%@", [[self.companyList objectAtIndex:[indexPath row]] stockPrice]];
//    cell.cellCompanyLogo.image = logoImage;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end



















