//
//  ACUViewController.m
//  Remindersv3
//
//  Created by Cheenar Banerjee on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ACUViewController.h"
#import "ACUReminder.h"

@interface ACUViewController  ()

@end

@implementation ACUViewController
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)addReminder:(id)sender
{
    ACUReminder *newReminder = [[ACUReminder alloc] init];
    newReminder.reminderName = self.nameTextField.text;
    newReminder.reminderDescription = self.descriptionTextField.text;
    newReminder.reminderDate = self.datePicker.date;
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = newReminder.reminderName;
    note.fireDate = newReminder.reminderDate;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
    
//    NSDate *date = self.datePicker.date;
//    NSLog(@"Setting a reminder for %@", date);
//    
//    UILocalNotification *note = [[UILocalNotification alloc] init];
//    note.alertBody = @"Hypnotize me!";
//    note.fireDate = date;
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
