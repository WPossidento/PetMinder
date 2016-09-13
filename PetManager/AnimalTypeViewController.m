//
//  AnimalTypeViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "AnimalTypeViewController.h"
#import "DAO.h"
#import "PetsTableViewCell.h"
#import "Pet.h"
#import "AnimalType.h"


@interface AnimalTypeViewController ()
@property (strong, nonatomic) DAO *dao;

@end

@implementation AnimalTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animalTypeTableView.delegate = self;
    self.animalTypeTableView.dataSource = self;
    self.dao = [DAO sharedInstance];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dao.animalTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PetsTableViewCell";
    PetsTableViewCell *cell = (PetsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIImage *animalImage = [UIImage imageNamed:[[self.dao.animalTypes objectAtIndex:[indexPath row]] image]];
    if (animalImage == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
        NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[[self.dao.animalTypes objectAtIndex:[indexPath row]] image]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        animalImage = [UIImage imageWithData:imageData];
    }
    
//    cell.textLabel.text = self.dao.animalTypes[indexPath.row].name;
    cell.petCellName.text = self.dao.animalTypes[indexPath.row].name;
    cell.petCellImage.image = animalImage;
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Pet *newPet = [[Pet alloc] init];
    newPet.animalType = self.dao.animalTypes[indexPath.row];
    newPet.petImage = newPet.animalType.image;
    
    if (self.petProfileViewController == nil) {
        self.petProfileViewController = [[PetProfileViewController alloc] initWithNibName:@"PetProfileViewController" bundle:nil];
    }
    
    self.petProfileViewController.pet = newPet;
    [self.navigationController pushViewController:self.petProfileViewController animated:YES];
    
    
//        
//        ProductViewController *productViewController =
//        [[ProductViewController alloc]
//         initWithNibName:@"ProductViewController" bundle:nil];
//        
//        // self.productViewController = [[[NSBundle mainBundle] loadNibNamed:@"ProductViewController" owner:self options:nil] objectAtIndex:0];
//        
//        productViewController.title = [[self.companyList objectAtIndex:indexPath.row] companyName];
//        productViewController.company = [self.companyList objectAtIndex:indexPath.row];
//        self.dao.company = [self.companyList objectAtIndex:indexPath.row];
//        [self.navigationController pushViewController:productViewController
//                                             animated:YES];
//        
//        [productViewController release];
//    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addAnimalTypeButton:(id)sender {
}





@end