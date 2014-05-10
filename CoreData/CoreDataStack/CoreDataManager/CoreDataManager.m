//
//  CoreDataManager.m
//  CoreData
//
//  Created by Alex Terente on 5/7/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import "CoreDataManager.h"
#import "CoreDataManager+Helper.h"
@interface CoreDataManager ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong) NSPersistentStoreCoordinator
                                                   *persistentStoreCoordinator;

@property (nonatomic, strong, readwrite) NSManagedObjectContext
                                                   *managedObjectContext;

@end

@implementation CoreDataManager

#pragma mark - SharedInstance
+ (instancetype)sharedInstance {
    static CoreDataManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Init
- (id)init {
    self = [super init];
    if (self != nil) {
        [self setUpManagedObjectModel];
        [self setUpPersistentStoreCoordinator];
        [self setUPManagedObjectContext];
        
    }
    return self;
}

- (void)setUpManagedObjectModel{
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
}


- (void)setUpPersistentStoreCoordinator{
   NSString *path = [self databasePath];
   NSURL *storeUrl = [NSURL fileURLWithPath:path];
   NSError *error = nil;
    
   _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:_managedObjectModel];
    
   NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                             NSInferMappingModelAutomaticallyOption:      @YES};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeUrl
                                                         options:options
                                                           error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)setUPManagedObjectContext{
   _managedObjectContext = [[NSManagedObjectContext alloc] init];
   [_managedObjectContext setPersistentStoreCoordinator:
                                                    _persistentStoreCoordinator];
   [_managedObjectContext setUndoManager:nil];
   [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
}

- (void)saveContext {
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Fetch Data
- (NSArray *)fetchManagedObjectsForEntity:(NSString *)entityName
                            withPredicate:(NSPredicate *)predicate {
    
   NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                             inManagedObjectContext:_managedObjectContext];
   NSFetchRequest *request = [[NSFetchRequest alloc] init];
   request.entity = entity;
   request.predicate = predicate;
   NSArray  *results = [_managedObjectContext executeFetchRequest:request
                                                            error:nil];
    
  return results;
}

- (void)addiCloudStore{
    NSString *path = [self databasePath];
    NSURL *storeUrl = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    NSDictionary *storeOptions =
    @{NSPersistentStoreUbiquitousContentNameKey: @"CoreData_CodeCamp"};
    NSPersistentStore *store =
    [_persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
                                              configuration:nil
                                                        URL:storeUrl
                                                    options:storeOptions
                                                      error:&error];
    NSLog(@"Store:%@",[store description]);
}

@end
