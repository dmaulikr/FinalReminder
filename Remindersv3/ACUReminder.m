//
//  ACUReminder.m
//  Remindersv3
//
//  Created by Cheenar Banerjee on 7/8/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ACUReminder.h"


@implementation ACUReminder

@dynamic reminderName;
@dynamic reminderDescription;
@dynamic reminderDate;

+ (NSEntityDescription *)entityWithContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:@"ACUReminder"
                       inManagedObjectContext:context];
}

+ (instancetype)insertNewInContext:(NSManagedObjectContext *)context {
    return [[ACUReminder alloc] initWithEntity:[self entityWithContext:context]
                insertIntoManagedObjectContext:context];
}

@end
