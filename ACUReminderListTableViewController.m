//
//  ACUReminderListTableViewController.m
//  Remindersv3
//
//  Created by Allie Burton on 7/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ACUNewReminderViewController.h"
#import "ACUReminderListTableViewController.h"
#import "ACUReminderTableViewCell.h"
#import "ACUReminderStore.h"
#import "ACUReminder.h"

@interface ACUReminderListTableViewController ()

@end

@implementation ACUReminderListTableViewController

#pragma View Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"ACUReminderTableViewCell" bundle:nil];
    
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ACUReminderTableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[ACUReminderStore sharedStore] allReminders] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    ACUReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ACUReminderTableViewCell" forIndexPath:indexPath];
    NSArray *reminders = [[ACUReminderStore sharedStore] allReminders];
    ACUReminder *reminder = reminders[indexPath.row];
    NSLog(@"%@", reminders);
    
    // Configure the cell with the reminder
    cell.titleLabel.text = reminder.reminderName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    cell.dateLabel.text = [formatter stringFromDate:reminder.reminderDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ACUNewReminderViewController *reminderViewController = [[ACUNewReminderViewController alloc] init];
    
    
    
    [self performSegueWithIdentifier:@"Segue" sender:reminderViewController];
    
//    [self.navigationController pushViewController:reminderViewController animated:YES];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Segue"]) {
        ACUNewReminderViewController *newController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *reminders = [[ACUReminderStore sharedStore] allReminders];
        ACUReminder *selectedReminder = reminders[indexPath.row];
        
        newController.reminder = selectedReminder;
    }
    
}

#pragma New Reminder Methods



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
