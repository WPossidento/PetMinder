//
//  PetProfileViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"
#import "PetListViewController.h"
@class PetListViewController;

@interface PetProfileViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *petImage;

- (IBAction)editImage:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *petName;

@property (strong, nonatomic) IBOutlet UITextField *petDescription;

@property (strong, nonatomic) IBOutlet UITextField *petColor;

@property (strong, nonatomic) IBOutlet UIPickerView *petSex;

@property (strong, nonatomic) IBOutlet UIDatePicker *petDateOfBirth;

@property (strong, nonatomic) Pet *pet;
@property (nonatomic, retain) PetListViewController *petListViewController;

- (IBAction)saveButton:(id)sender;

@end
