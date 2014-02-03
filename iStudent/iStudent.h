//
//  iStudent.h
//  iStudent
//
//  Created by Kobe Dai on 9/5/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iStudent : NSObject

// get instance: Singleton
+ (iStudent *)sharedInstance;

- (void)performFetch: (NSFetchedResultsController *)controller;

- (NSFetchedResultsController *)getFRCWithEntityName: (NSString *)entityName
                                             withKey: (NSString *)key;

- (NSFetchedResultsController *)getFRCWithEntityName: (NSString *)entityName
                                            withKey1: (NSString *)key1
                                            withKey2: (NSString *)key2;

@end
