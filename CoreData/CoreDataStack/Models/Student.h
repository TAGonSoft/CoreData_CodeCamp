//
//  Student.h
//  CoreData
//
//  Created by Alex Terente on 5/7/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *notes;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
