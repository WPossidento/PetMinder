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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.petName.text = self.pet.name;
    self.taskName.text = @"";
    self.noteTextField.text = @"";
}

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
