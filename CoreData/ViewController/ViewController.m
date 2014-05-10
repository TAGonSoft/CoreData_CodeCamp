//
//  ViewController.m
//  CoreData
//
//  Created by Alex Terente on 5/5/14.
//  Copyright (c) 2014 TAGonSoft. All rights reserved.
//

#import "ViewController.h"

#import "CoreDataManager.h"
#import "Student.h"
#import "Note.h"


@interface ViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) CoreDataManager *cdManager;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation ViewController

#pragma mark - MemoryManagement
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Notifications
- (void)reloadNotification:(NSNotification *)aNotificaiton{
    [self loadDataSource];
    [self.tableView reloadData];
}

#pragma mark - ViewLife Circle
- (void)viewDidLoad {
  [super viewDidLoad];
    
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reloadNotification:)
                                               name:LongTaskFinishNotification
                                             object:nil];
    
  _cdManager = [CoreDataManager sharedInstance];
  _context   =  _cdManager.managedObjectContext;
  
  //[self insertObjects];
  //[self deleteStudent];
  [self longTaskOperation];
    
    
    [self loadDataSource];
    /*
    for (Student *current in _dataSourceArray) {
        current.gender = @"male";
    }
     */
}

- (void)loadDataSource{
    _dataSourceArray =
    [_cdManager fetchManagedObjectsForEntity:@"Student"
                               withPredicate:nil];
    
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    Student *currentStudent = _dataSourceArray[indexPath.row];
    cell.textLabel.text = currentStudent.name;
    cell.detailTextLabel.text = currentStudent.gender;
    
    return cell;
}















- (void)deleteStudent{
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"Tyler"];
    
   NSArray *students = [[CoreDataManager sharedInstance]
                        fetchManagedObjectsForEntity:@"Student"
                                       withPredicate:predicate];
    if([students count]){
       Student *tyler = students[0];
       [[CoreDataManager sharedInstance].managedObjectContext deleteObject:tyler];
    }
    [_cdManager saveContext];
}

- (void)insertObjects{
   
    Student *johnStudent = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Student"
                            inManagedObjectContext:_context];
    johnStudent.name = @"Jhon";
    johnStudent.birthday = @"10 May";
    
    
    Student *tylerStudent = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Student"
                             inManagedObjectContext:_context];
    tylerStudent.name = @"Tyler";
    tylerStudent.birthday = @"8 August";
    [[CoreDataManager sharedInstance] saveContext];
}

- (void)longTaskOperation{
    LongTaskOperation *operation = [[LongTaskOperation alloc] init];
    _queue = [[NSOperationQueue alloc] init];
    [_queue addOperation:operation];
}





@end