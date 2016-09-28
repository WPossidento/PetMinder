//
//  TaskInfoViewController.h
//  PetManager
//
//  Created by Olivia Taylor on 9/23/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Pet.h"
#import "DAO.h"


@interface TaskInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *taskForPetNameInfo;
@property (strong, nonatomic) IBOutlet UIImageView *infoPetImage;
@property (strong, nonatomic) IBOutlet UILabel *infoTaskName;
@property (strong, nonatomic) IBOutlet UILabel *infoTaskNote;
@property (strong, nonatomic) IBOutlet UILabel *infoTaskDate;


@property (strong, nonatomic) Task *task;
@property (strong, nonatomic) Pet *pet;

@end
