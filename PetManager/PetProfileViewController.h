//
//  PetProfileViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *petImage;

@property (strong, nonatomic) IBOutlet UITextField *petName;

@property (strong, nonatomic) IBOutlet UITextField *petDescription;

@property (strong, nonatomic) IBOutlet UITextField *petColor;

@property (strong, nonatomic) IBOutlet UIPickerView *petSex;

@property (strong, nonatomic) IBOutlet UIDatePicker *petDateOfBirth;

- (IBAction)saveButton:(id)sender;

@end
