//
//  PetProfileViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "PetProfileViewController.h"
#import "DAO.h"


@interface PetProfileViewController ()

@property(strong, nonatomic) NSString *pickerViewSex;
@property (strong, nonatomic) DAO *dao;

@end

@implementation PetProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _petSex.delegate = self;
    _petSex.dataSource = self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.petImage.image = [UIImage imageNamed:self.pet.petImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    
    self.pet.name = self.petName.text;
    
    
 //   NSString *imagestring = [UIImagePNGRepresentation(self.petImage.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    [[DAO sharedInstance]createPetWithName:self.petName.text andImage:self.pet.petImage  andColor:self.petColor.text andMiscDescription:self.petDescription.text andBirthdate:self.petDateOfBirth.date andSex:self.pickerViewSex andAnimalType:self.pet.animalType];
    
    [self.dao.allPets addObject:self.pet];
    
    if (self.petListViewController == nil) {
        self.petListViewController = [[PetListViewController alloc] init];
    }
    
    [self.navigationController pushViewController:self.petListViewController animated:YES];
    
}

-(void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (row == 0) {
        
        _pickerViewSex = @"male";
        
    } else {
        
        _pickerViewSex = @"female";
    }
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == 0) {
        
        NSString *str = @"male";
        
        return str;
        
    } else {
        
        NSString *str = @"female";
        
        return str;
    }
    
}

@end


















