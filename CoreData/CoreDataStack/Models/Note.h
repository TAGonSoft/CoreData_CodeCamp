//
//  Note.h
//  CoreData
//
//  Created by Alex Terente on 5/7/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * fieldOfStudy;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSManagedObject *student;

@end
