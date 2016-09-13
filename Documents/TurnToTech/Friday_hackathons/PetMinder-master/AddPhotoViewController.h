//
//  AddPhotoViewController.h
//  PetManager
//
//  Created by Macbook Pro on 9/12/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;

- (IBAction)selectPhoto:(id)sender;

@end
