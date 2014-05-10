//
//  LongTaskOperation.m
//  CoreData
//
//  Created by Alex on 5/8/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import "LongTaskOperation.h"
#import "Student.h"
#import "CoreDataManager.h"

NSString *const LongTaskFinishNotification = @"LongTaskFinishNotification";

@interface LongTaskOperation ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation LongTaskOperation

- (void)mergeContexts:(NSNotification *)aNotification {
    [[[CoreDataManager sharedInstance] managedObjectContext]
     mergeChangesFromContextDidSaveNotification:aNotification];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LongTaskFinishNotification object:nil];
}

- (void)main{
    [self initContext];
    
    [NSThread sleepForTimeInterval:6];

    Student *student = [self insertStudent];
    student.birthday = @"22 April";
    
    //subscribe current object for context notification saves
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeContexts:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:_context];
    [self saveContext];
}



- (void)initContext{
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:[CoreDataManager sharedInstance].persistentStoreCoordinator];
    [_context setUndoManager:nil];
    [_context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
}

- (Student *)insertStudent{
   Student *student = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Student"
                                inManagedObjectContext:_context];
    student.name = @"LongTaskStudent";
    student.birthday = @"9 May";
    return  student;
}

- (void)saveContext{
    NSError *error;
    if (![_context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
