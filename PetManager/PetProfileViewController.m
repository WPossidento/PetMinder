//
//  PetProfileViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "PetProfileViewController.h"
#import "DAO.h"


@interface PetProfileViewController ()


@property(strong, nonatomic) NSString *pickerViewSex;
@property (strong, nonatomic) DAO *dao;

@end

@implementation PetProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    _petSex.delegate = self;
    _petSex.dataSource = self;
    
    
    self.petImage.image = [UIImage imageNamed:self.pet.petImage];
    
}

-(void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(id)sender {
    
    self.pet.name = self.petName.text;
    
 //   NSString *imagestring = [UIImagePNGRepresentation(self.petImage.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    // save image to file in documents directory
    // set self.pet.petImage to filePath
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSURL *fileURL = [documentsURL URLByAppendingPathComponent:[NSString stringWithFormat:@"pet_id_%@.png", self.petName.text]];
    self.pet.petImage = [fileURL path];
    NSData *imageData = UIImagePNGRepresentation(self.petImage.image);
    [imageData writeToFile:self.pet.petImage atomically:YES];

    
    
    self.pet = [[DAO sharedInstance]createPetWithName:self.petName.text andImage:self.pet.petImage andColor:self.petColor.text andMiscDescription:self.petDescription.text andBirthdate:self.petDateOfBirth.date andSex:self.pickerViewSex andAnimalType:self.pet.animalType];
    
    [self.dao.allPets addObject:self.pet];
    
 
 
    
    
    if (self.petListViewController == nil) {
        self.petListViewController = [[PetListViewController alloc] init];
    }
    
    [self.navigationController pushViewController:self.petListViewController animated:YES];
    
}

-(void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (row == 0) {
        
        _pickerViewSex = @"male";
        
    } else {
        
        _pickerViewSex = @"female";
    }
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == 0) {
        
        NSString *str = @"male";
        
        return str;
        
    } else {
        
        NSString *str = @"female";
        
        return str;
    }
    
}

- (IBAction)editImage:(id)sender {
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Change image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet
                                ];
    
    UIAlertAction *takePhoto = [UIAlertAction
                                actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                    
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;
                                    picker.allowsEditing = YES;
                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    
                                    [self presentViewController:picker animated:YES completion:NULL];
                                    
                                    
                                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                        
                                        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                                                            message:@"Device has no camera"
                                                                                                     preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                                                              style:UIAlertActionStyleDestructive
                                                                                            handler:^(UIAlertAction *action) {
                                                                                                NSLog(@"Dismiss button tapped!");
                                                                                            }];
                                        [controller addAction:alertAction];
                                        [self presentViewController:controller animated:YES completion:nil];
                                    }
                                    
                                }
                                ];
 
    
    UIAlertAction *selectPhoto = [UIAlertAction
                                actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                    
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;
                                    picker.allowsEditing = YES;
                                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                    
                                    [self presentViewController:picker animated:YES completion:NULL];
                                    
                                }
                                ];
    
    
    UIAlertAction *cancel = [UIAlertAction
                                  actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                  {

                                      [alert dismissViewControllerAnimated:YES completion:NULL];
                                      
                                  }
                                  ];
    
    [alert addAction:takePhoto];
    [alert addAction:selectPhoto];
    [alert addAction:cancel];
    
 [self presentViewController:alert animated:YES completion:NULL];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.petImage.image = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}




@end


















