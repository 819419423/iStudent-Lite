//
//  iStudent.m
//  iStudent
//
//  Created by Kobe Dai on 9/5/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "iStudent.h"

static iStudent *_iStudent = nil;

@implementation iStudent

+ (iStudent *)sharedInstance {
    
    static iStudent *iStudent = nil;
    
    iStudent = [[self alloc] init];
    
    _iStudent = iStudent;
    
    return _iStudent;
}

- (void)performFetch:(NSFetchedResultsController *)controller
{
    if (controller)
    {
        NSError *error;
        [controller performFetch:&error];
        if (error) NSLog(@"ERROR PERFORMING FETCH:\n[%@ %@-%@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), controller.fetchRequest.entityName, [error localizedDescription], [error localizedFailureReason]);
    }
}

- (NSFetchedResultsController *)getFRCWithEntityName:(NSString *)entityName
                                             withKey:(NSString *)key
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: entityName];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: [[NSSortDescriptor alloc] initWithKey: key ascending: YES selector: @selector(compare:)], nil];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                          managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                            sectionNameKeyPath: nil
                                                                                     cacheName: nil];
    
    return frc;
}

- (NSFetchedResultsController *)getFRCWithEntityName:(NSString *)entityName
                                            withKey1:(NSString *)key1
                                            withKey2:(NSString *)key2
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: entityName];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: [[NSSortDescriptor alloc] initWithKey: key1 ascending: YES selector: @selector(compare:)],
                                                                 [[NSSortDescriptor alloc] initWithKey: key2 ascending: YES selector: @selector(compare:)], nil];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                          managedObjectContext: [AppDelegate sharedDelegate].managedObjectContext
                                                                            sectionNameKeyPath: nil
                                                                                     cacheName: nil];
    
    return frc;
}

@end
