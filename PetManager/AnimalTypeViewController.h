//
//  AnimalTypeViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalTypeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *animalTypeTextField;

- (IBAction)addAnimalTypeButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *animalTypeTableView;

@end
