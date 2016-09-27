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
    
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField * textField = (UITextField*)view;
            textField.delegate = self;
        }
    }
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        NSArray *animalTypes = [self.dao animalTypes];
        
        AnimalType *animalType = [animalTypes objectAtIndex:indexPath.row];
        
        [self.dao deleteAnimalTypeWithID:animalType.animalType_id];
        
        [[self.dao animalTypes]removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
    }
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
    
}


- (IBAction)addAnimalTypeButton:(id)sender {
    
    NSString *animalType = self.animalTypeTextField.text;
    
    self.animalTypeTextField.text = @"";
    
    [[DAO sharedInstance]addAnimalTypeWithName:animalType andImage:@"text-list"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:animalType message:@"added" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self.animalTypeTableView reloadData];
                             
                         }];
    
    [alert addAction:ok];
    
    [self.animalTypeTextField endEditing:YES];
    [self presentViewController:alert animated:YES completion:NULL];
    
    }


#pragma mark - UITextfieldDelegate


-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.animalTypeTextField endEditing:YES];

}

@end
