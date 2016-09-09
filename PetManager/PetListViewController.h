//
//  PetListViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalType.h"
#import "AnimalTypeViewController.h"

@interface PetListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *petListTableView;
@property (nonatomic, retain) AnimalTypeViewController *animalTypeViewController;

- (IBAction)addPetButton:(id)sender;

@end
