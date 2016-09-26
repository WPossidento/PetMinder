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
@property CGFloat currentKeyboardHeight;

@end

@implementation TaskFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recurringSwitch.hidden = YES;
    self.recurringLabel.hidden = YES;
    self.noteTextField.delegate = self;
    self.taskName.delegate = self;

    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButton:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    self.dao = [DAO sharedInstance];
    
    //Set tag so only noteTextField changes position during keyboard
    self.noteTextField.tag = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.currentKeyboardHeight = kbSize.height;
    
    if (self.noteTextField.isEditing == TRUE){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = [self.view frame];
             newFrame.origin.y -= _currentKeyboardHeight; // tweak here to adjust the moving position
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {

    if (self.noteTextField.isEditing == TRUE){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = [self.view frame];
             newFrame.origin.y += self.currentKeyboardHeight; // tweak here to adjust the moving position
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.recurringSwitch.hidden = YES;
    self.recurringLabel.hidden = YES;
    self.petName.text = self.pet.name;
    self.taskName.text = @"";
    self.noteTextField.text = @"";
}

- (IBAction)saveButton:(id)sender {
    self.task = [[DAO sharedInstance]createTaskWithName:self.taskName.text andNote:self.noteTextField.text andTime:self.datePicker.date andPet:self.pet];
    
    [self.dao.allTasks addObject:self.task];
    
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
