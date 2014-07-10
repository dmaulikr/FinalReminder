//
//  ACUNewReminderViewController.h
//  Reminders
//
//  Created by Allie Burton on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACUReminder;

@interface ACUNewReminderViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ACUReminder *reminder;

@property (weak, nonatomic) IBOutlet UITextField *reminderNameField;

@property (weak, nonatomic) IBOutlet UITextView *reminderDescriptionView;
@property (weak, nonatomic) IBOutlet UITextField *reminderDateField;
@property (weak, nonatomic) UIDatePicker *picker;
@end
