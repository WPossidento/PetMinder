//
//  PetsTableViewCell.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *petCellImage;
@property (strong, nonatomic) IBOutlet UILabel *petCellName;

@end
