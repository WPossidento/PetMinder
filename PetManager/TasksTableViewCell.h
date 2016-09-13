//
//  TasksTableViewCell.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TasksTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *taskTableCellImage;
@property (strong, nonatomic) IBOutlet UILabel *taskTableCellTaskName;
@property (strong, nonatomic) IBOutlet UILabel *taskTableCellPetName;

@end
