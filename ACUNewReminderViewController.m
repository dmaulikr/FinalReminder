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

@interface ACUNewReminderViewController ()

@end

@implementation ACUNewReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Add a border to the description text box
    [_reminderDescription.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_reminderDescription.layer setBorderWidth:0.5];
    
    // Give the border rounded edges
    _reminderDescription.layer.cornerRadius = 5.0;
    _reminderDescription.clipsToBounds = YES;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    _reminderDate.inputView = datePicker;
    
    [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
    
    
    
    // NSString *strDate = [formatter stringFromDate:datePicker.date]
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma New Reminder Methods

- (IBAction)addReminder:(id)sender {
    
    ACUReminder *newReminder = [[ACUReminder alloc] init];
    newReminder.reminderName = self.reminderName.text;
    newReminder.reminderDescription = self.reminderDescription.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    newReminder.reminderDate = [formatter dateFromString:_reminderDate.text];
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = newReminder.reminderName;
    note.fireDate = newReminder.reminderDate;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    [sender resignFirstResponder];
}

- (void)updateDateField:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)_reminderDate.inputView;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    _reminderDate.text = [formatter stringFromDate:picker.date];
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
