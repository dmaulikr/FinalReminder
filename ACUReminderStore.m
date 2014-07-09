//
//  ACUReminderStore.m
//  Remindersv3
//
//  Created by Cheenar Banerjee on 7/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ACUReminderStore.h"
#import "ACUReminder.h"

@import CoreData;

@interface ACUReminderStore ()

@property (nonatomic) NSMutableArray *privateReminders;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation ACUReminderStore

+ (instancetype)sharedStore
{
    static ACUReminderStore *sharedStore;
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    [NSException raise:@"Singleton"
                format: @"Use + [ACUReminderStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        NSError *error;
        
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            [NSException raise:@"Open Failure" format:[error localizedDescription]];
        }
        
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllReminders];
    }
    
    return self;
}

- (NSArray *)allReminders
{
    return [self.privateReminders copy];
}

- (ACUReminder *)addReminder
{
    ACUReminder *reminder = [NSEntityDescription insertNewObjectForEntityForName:@"ACUReminder" inManagedObjectContext:self.context];
    
    [self.privateReminders addObject:reminder];
    
    return reminder;
}

- (void)removeReminder:(ACUReminder *)reminder
{
    [self.context deleteObject:reminder];
    [self.privateReminders removeObjectIdenticalTo:reminder];
    [self loadAllReminders];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful)
    {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (void)loadAllReminders
{
    if (!self.privateReminders)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"ACUReminder" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            [NSException raise:@"Fetch failed" format: @"Reason: %@", [error localizedDescription]];
        }
        
        self.privateReminders = [[NSMutableArray alloc] initWithArray:result];        
    }
}



@end
