//
//  ACUNewReminderViewController.h
//  Reminders
//
//  Created by Allie Burton on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACUNewReminderViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *reminderNameField;

@property (weak, nonatomic) IBOutlet UITextView *reminderDescriptionView;
@property (weak, nonatomic) IBOutlet UITextField *reminderDateField;
@end
