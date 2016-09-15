//
//  TaskFormViewController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TaskFormViewController.h"
#import "DAO.h"

@interface TaskFormViewController ()

@property (strong, nonatomic) DAO *dao;

@end

@implementation TaskFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteTextField.delegate = self;
    self.taskName.delegate = self;

    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    self.dao = [DAO sharedInstance];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.petName.text = self.pet.name;
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
    [self.dao createTaskWithName:self.taskName.text andNote:self.noteTextField.text andTime:self.datePicker.date andPet:self.pet];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextfieldDelegate

-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.taskName endEditing:YES];
    [self.noteTextField endEditing:YES];
    
}


@end
