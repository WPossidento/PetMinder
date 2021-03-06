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
@property(strong, nonatomic) UILabel *simpleGuidePhraseIfNoPets;

@end

@implementation PetListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00 green:0.65 blue:1.00 alpha:1.0];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    self.tabBarItem.image = [[UIImage imageNamed:@"pet-dog"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPetButton:)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    
}

- (void)viewWillAppear:(BOOL)animated {

    self.title = @"Pets";
    self.dao = [DAO sharedInstance];
    [[DAO sharedInstance] loadAllPets];
    self.allPets = self.dao.allPets;
    
    self.simpleGuidePhraseIfNoPets = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 70)];
    self.simpleGuidePhraseIfNoPets.textAlignment = NSTextAlignmentCenter;
    [self.simpleGuidePhraseIfNoPets sizeToFit];
    [self.view addSubview:self.simpleGuidePhraseIfNoPets];
    CGRect myFrame = CGRectMake(0, 0, 300, 70);
    self.simpleGuidePhraseIfNoPets.bounds = myFrame;
    self.simpleGuidePhraseIfNoPets.center = self.view.center;
    
    if (self.dao.allPets.count == 0){
        self.simpleGuidePhraseIfNoPets.text = @"Click on the + to add your (first) pet";
    } else {
        self.simpleGuidePhraseIfNoPets.text = @"";
    }
    
    [self.petListTableView reloadData];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.simpleGuidePhraseIfNoPets.text = @"";
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
    
//    NSString *petImg = [[self.dao.allPets objectAtIndex:[indexPath row]] petImage];
    
//    UIImage *petImage = [UIImage imageNamed:petImg];
//        if (petImage == nil) {
//           //NSFileManager *fileManager = [NSFileManager defaultManager];
//           // NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
//           // NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.dao.allPets objectAtIndex:[indexPath row]] petImage]];
//            NSURL *fileURL = [NSURL fileURLWithPath:petImg ] ;
//            NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
//            petImage = [UIImage imageWithData:imageData];
//        }
    
    cell.petCellImage.image = [[self.dao.allPets objectAtIndex:[indexPath row]]loadedImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tasksForPetViewController == nil) {
        self.tasksForPetViewController = [[TasksForPetViewController alloc] initWithNibName:@"TasksForPetViewController" bundle:nil];
    }
    
    if (self.tasksForPetViewController.pet == nil){
        self.tasksForPetViewController.pet = [[Pet alloc]init];
    }
    
    self.tasksForPetViewController.pet = self.allPets[indexPath.row];
    self.tasksForPetViewController.title = [NSString stringWithFormat:@"Tasks for %@", [self.allPets[indexPath.row] name]];
    [self.navigationController pushViewController:self.tasksForPetViewController animated:YES];
    
//    if (self.petProfileViewController == nil) {
//        self.petProfileViewController = [[PetProfileViewController alloc] initWithNibName:@"PetProfileViewController" bundle:nil];
//    }
//    
//    self.petProfileViewController.pet = newPet;
//    [self.navigationController pushViewController:self.petProfileViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        NSArray *pets = [self.dao allPets];
        
        Pet *pet = [pets objectAtIndex:indexPath.row];
        
        [self.dao deletePetWithPetID:pet.petID];
        
        [[self.dao allPets]removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (self.dao.allPets.count == 0){
            self.simpleGuidePhraseIfNoPets.text = @"Click on the + to add your (first) pet";
        } else {
            self.simpleGuidePhraseIfNoPets.text = @"";
        }
        
        [tableView reloadData];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
