//
//  CoreDataManager.h
//  CoreData
//
//  Created by Alex Terente on 5/7/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (NSArray *)fetchManagedObjectsForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (void)saveContext;

@end
