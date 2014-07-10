//
//  ACUNewReminderViewController.m
//  Reminders
//
//  Created by Allie Burton on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ACUNewReminderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ACUReminder.h"
#import "ACUAppDelegate.h"
#import "ACUReminderStore.h"

@interface ACUNewReminderViewController ()

@property (strong, nonatomic)IBOutlet UITapGestureRecognizer *tap;

@end

@implementation ACUNewReminderViewController

#pragma View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add a border to the description text box
    [self.reminderDescriptionView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.reminderDescriptionView.layer setBorderWidth:0.5];
    
    // Give the border rounded edges
    self.reminderDescriptionView.layer.cornerRadius = 5.0;
    self.reminderDescriptionView.clipsToBounds = YES;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    self.reminderDateField.inputView = datePicker;
    self.picker = datePicker;
    
    NSLog(@"%@", [[ACUReminderStore sharedStore] allReminders]);
    
    [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ACUReminder *reminder = self.reminder;
    
    self.reminderNameField.text = reminder.reminderName;
    self.reminderDescriptionView.text = reminder.reminderDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.reminderDateField.text = [formatter stringFromDate:reminder.reminderDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UI Methods

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
    [self.reminderNameField resignFirstResponder];
    [self.reminderDescriptionView resignFirstResponder];
    [self.reminderDateField resignFirstResponder];

}

- (IBAction)addReminder:(id)sender {
    
    self.reminder = [[ACUReminderStore sharedStore] addReminder];
    self.reminder.reminderName = self.reminderNameField.text;
    self.reminder.reminderDescription = self.reminderDescriptionView.text;
    self.reminder.reminderDate = self.picker.date;
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = self.reminder.reminderName;
    note.fireDate = self.reminder.reminderDate;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    [[ACUReminderStore sharedStore] saveChanges];
    [self resignFirstResponder];
}


- (void)updateDateField:(id)sender {    
    UIDatePicker *picker = (UIDatePicker *)self.picker;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.reminderDateField.text = [formatter stringFromDate:picker.date];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
