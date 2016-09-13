//
//  PetListViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "PetListViewController.h"
#import "PetsTableViewCell.h"
#import "DAO.h"
#import "Pet.h"

@interface PetListViewController ()

@property(strong, nonatomic) DAO *dao;

@end

@implementation PetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {

    self.dao = [DAO sharedInstance];
    [[DAO sharedInstance] loadAllPets];
    self.allPets = self.dao.allPets;
    [self.petListTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPetButton:(id)sender {
    if (self.animalTypeViewController == nil) {
        self.animalTypeViewController = [[AnimalTypeViewController alloc] init];
    }
    
    self.animalTypeViewController.title = @"What type of animal is your pet?";
    
    
    [self.navigationController pushViewController:self.animalTypeViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dao.allPets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PetsTableViewCell";
    PetsTableViewCell *cell = (PetsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.petCellName.text = [NSString stringWithFormat:@"%@", [self.dao.allPets[indexPath.row] name]];
    
    UIImage *petImage = [UIImage imageNamed:[[self.dao.allPets objectAtIndex:[indexPath row]] petImage]];
        if (petImage == nil) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
            NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.dao.allPets objectAtIndex:[indexPath row]] petImage]];
            NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
            petImage = [UIImage imageWithData:imageData];
        }
    
    cell.petCellImage.image = petImage;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
