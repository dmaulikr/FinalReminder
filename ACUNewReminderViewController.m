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
@property (weak, nonatomic) UIDatePicker *picker;

@end

@implementation ACUNewReminderViewController

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
    
    [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"%@",[[ACUReminderStore sharedStore] allReminders]);
    
    // NSString *strDate = [formatter stringFromDate:datePicker.date]
    

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

#pragma New Reminder Methods

- (IBAction)addReminder:(id)sender {
    ACUReminder *newReminder = [[ACUReminderStore sharedStore] addReminder];
    newReminder.reminderName = self.reminderNameField.text;
    newReminder.reminderDescription = self.reminderDescriptionView.text;
    newReminder.reminderDate = self.picker.date;
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = newReminder.reminderName;
    note.fireDate = newReminder.reminderDate;
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
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
