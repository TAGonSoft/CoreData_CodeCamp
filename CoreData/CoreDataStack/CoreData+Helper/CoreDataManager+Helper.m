//
//  CoreDataManager+Helper.m
//  CoreData
//
//  Created by Alex on 5/8/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import "CoreDataManager+Helper.h"

@implementation CoreDataManager (Helper)

#pragma mark - Helpers
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)databasePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"CodeCamp.sqlite"];
}

@end
