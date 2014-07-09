//
//  ACUReminderStore.h
//  Remindersv3
//
//  Created by Cheenar Banerjee on 7/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACUReminder;

@interface ACUReminderStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allReminders;

+ (instancetype) sharedStore;
- (ACUReminder *)addReminder;
- (void)removeReminder:(ACUReminder *)reminder;
//- (void)moveItemAtIndex:(NSUInteger)fromIndex
//                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;

@end
