//
//  AppDelegate.h
//  iStudent
//
//  Created by Kobe Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext              *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel                *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator        *persistentStoreCoordinator;
@property (strong, nonatomic) MBProgressHUD                                 *hud;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (AppDelegate *)sharedDelegate;

@end
