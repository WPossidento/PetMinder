//
//  TaskInfoViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/23/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskInfoViewController.h"

@interface TaskInfoViewController ()

@property (strong, nonatomic) DAO *dao;

@end

@implementation TaskInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.taskForPetNameInfo.text = [NSString stringWithFormat:@"Task for %@", self.pet.name];
    self.infoPetImage.image = self.pet.loadedImage;
    self.infoTaskName.text = [NSString stringWithFormat:@"%@", self.task.taskName];
    self.infoTaskNote.text = [NSString stringWithFormat:@"%@", self.task.taskNote];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM d, yyyy @ h:mm a"];
    NSDate *theDate;
    theDate = self.task.time;
    
    self.infoTaskDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:theDate]];
}

@end
