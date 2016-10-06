//
//  ProfileForPetViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 10/6/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasksForPetViewController.h"
#import "Pet.h"
#import "DAO.h"
#import "PetProfileViewController.h"

@interface ProfileForPetViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelPetName;
@property (weak, nonatomic) IBOutlet UIImageView *imagePet;
@property (weak, nonatomic) IBOutlet UILabel *labelPetDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelPetColor;
@property (weak, nonatomic) IBOutlet UILabel *labelPetDOB;
@property (weak, nonatomic) IBOutlet UIImageView *iconPetSex;

@property (strong, nonatomic) Pet *pet;

@end
