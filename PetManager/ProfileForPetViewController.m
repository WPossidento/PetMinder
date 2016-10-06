//
//  ProfileForPetViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 10/6/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "ProfileForPetViewController.h"

@interface ProfileForPetViewController ()

@property (strong, nonatomic) DAO *dao;

@end

@implementation ProfileForPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DAO sharedInstance];
    
//    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self
//                                                                  action:@selector(editPet)];
//    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.labelPetName.text = self.pet.name;
    self.imagePet.image = self.pet.loadedImage;
    self.labelPetDesc.text = self.pet.petDescription;
    self.labelPetColor.text = self.pet.color;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy"];
    NSDate *theDate;
    theDate = self.pet.birthDate;
    
    self.labelPetDOB.text = [NSString stringWithFormat:@"Date of birth:\n%@", [formatter stringFromDate:theDate]];
    
}


@end
