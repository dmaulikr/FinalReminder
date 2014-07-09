//
//  ACUNewReminderViewController.h
//  Reminders
//
//  Created by Allie Burton on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACUNewReminderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *reminderName;

@property (weak, nonatomic) IBOutlet UITextView *reminderDescription;
@property (weak, nonatomic) IBOutlet UITextField *reminderDate;
@end
